#!/usr/bin/env python3
"""List Markdown candidates for a monthly tweet-summary post."""

from __future__ import annotations

import argparse
import datetime as dt
import re
from pathlib import Path


TWITTER_EPOCH_MS = 1288834974657
DEFAULT_TWEETS_ROOT = Path.home() / "⭐️ Documentación" / "Tweets"
SPANISH_MONTHS = {
    1: "enero",
    2: "febrero",
    3: "marzo",
    4: "abril",
    5: "mayo",
    6: "junio",
    7: "julio",
    8: "agosto",
    9: "septiembre",
    10: "octubre",
    11: "noviembre",
    12: "diciembre",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Print monthly tweet candidates from Docflow Markdown files using "
            "the site's tweet-summary filters."
        )
    )
    parser.add_argument("month", help="Month to export, in YYYY-MM format.")
    parser.add_argument(
        "--tweets-root",
        type=Path,
        default=DEFAULT_TWEETS_ROOT,
        help=f"Root folder containing 'Tweets YEAR' directories. Default: {DEFAULT_TWEETS_ROOT}",
    )
    parser.add_argument(
        "--author",
        default="@domingogallardo",
        help="Tweet author handle to include. Default: @domingogallardo",
    )
    parser.add_argument(
        "--start-day",
        type=int,
        default=1,
        help="First day of the month to include. Default: 1",
    )
    parser.add_argument(
        "--end-day",
        type=int,
        help="Last day of the month to include. Default: last day of month",
    )
    return parser.parse_args()


def parse_front_matter(text: str) -> tuple[dict[str, str], str]:
    if not text.startswith("---\n"):
        return {}, text

    end = text.find("\n---\n", 4)
    if end == -1:
        return {}, text

    front_matter: dict[str, str] = {}
    for line in text[4:end].splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        front_matter[key.strip()] = value.strip().strip('"')

    return front_matter, text[end + len("\n---\n") :]


def tweet_date(tweet_id: str) -> dt.date | None:
    if not tweet_id.isdigit():
        return None
    timestamp_ms = (int(tweet_id) >> 22) + TWITTER_EPOCH_MS
    return dt.datetime.fromtimestamp(timestamp_ms / 1000, tz=dt.UTC).date()


def tweet_id_from_url(url: str) -> str:
    match = re.search(r"/status/(\d+)", url)
    return match.group(1) if match else ""


def clean_tweet_lines(lines: list[str]) -> str:
    content: list[str] = []
    skip_next_image_target = False
    for line in lines:
        stripped = line.strip()
        if is_tweet_boundary(stripped):
            break
        if stripped.startswith("![avatar]"):
            continue
        if stripped.startswith("[![") or stripped.startswith("> [!["):
            skip_next_image_target = True
            continue
        if skip_next_image_target and stripped.startswith("("):
            skip_next_image_target = False
            continue
        skip_next_image_target = False
        content.append(line.rstrip())

    text = "\n".join(content).strip()
    return re.sub(r"\n{3,}", "\n\n", text)


def is_tweet_boundary(line: str) -> bool:
    if line in {"---", "·", "Views", "Relevant"}:
        return True

    return line.startswith(
        (
            "Original link:",
            "> [!link-card]",
            "[View quoted tweet]",
            "#### Tweet citado",
            "#### En respuesta a",
            "#### Tweet favorito",
            "#### Tweet anterior",
            "#### Tweet padre",
        )
    )


def strip_thread_leading_meta(lines: list[str]) -> list[str]:
    index = 0
    while index < len(lines) and not lines[index].strip():
        index += 1
    if index < len(lines) and lines[index].strip() == "·":
        index += 1
    if index < len(lines) and re.fullmatch(r"\d+[hm]", lines[index].strip()):
        index += 1
    while index < len(lines) and not lines[index].strip():
        index += 1
    return lines[index:]


def extract_thread_text(body: str, url: str) -> str:
    target_id = tweet_id_from_url(url)
    blocks = re.finditer(
        r"(?ms)^---\n\[View on X\]\(https://x\.com/[^/]+/status/(?P<id>\d+)\)\n(?P<body>.*?)(?=^---\n|\Z)",
        body,
    )

    fallback = ""
    for block in blocks:
        text = clean_tweet_lines(strip_thread_leading_meta(block.group("body").splitlines()))
        if text and not fallback:
            fallback = text
        if block.group("id") == target_id and text:
            return text

    return fallback


def extract_tweet_text(body: str, url: str) -> str:
    if "# Thread by " in body:
        return extract_thread_text(body, url)

    own_reply_marker = "#### Mi respuesta"
    if own_reply_marker in body:
        body = body.split(own_reply_marker, 1)[1]
        return clean_tweet_lines(body.splitlines())

    lines = body.splitlines()
    start = 0
    for index, line in enumerate(lines):
        if line.startswith("@"):
            start = index + 1
            break

    return clean_tweet_lines(lines[start:])


def blockquote(text: str) -> str:
    return "\n".join(f"> {line}" if line else ">" for line in text.splitlines())


def main() -> int:
    args = parse_args()
    try:
        year, month = (int(part) for part in args.month.split("-", 1))
        month_start = dt.date(year, month, 1)
    except ValueError:
        raise SystemExit("Month must use YYYY-MM format.")

    next_month = (
        dt.date(year + 1, 1, 1)
        if month == 12
        else dt.date(year, month + 1, 1)
    )
    try:
        first_day = dt.date(year, month, args.start_day)
        end_day = (
            next_month - dt.timedelta(days=1)
            if args.end_day is None
            else dt.date(year, month, args.end_day)
        )
    except ValueError as error:
        raise SystemExit(f"Invalid day range for {month_start:%Y-%m}: {error}") from error
    if end_day < first_day:
        raise SystemExit(
            "Invalid day range: --end-day must be greater than or equal to --start-day."
        )
    range_end = end_day + dt.timedelta(days=1)

    source_dir = args.tweets_root / f"Tweets {year}"
    if not source_dir.exists():
        raise SystemExit(f"Tweets directory not found: {source_dir}")

    candidates: list[tuple[dt.date, int, str, str]] = []
    for path in sorted(source_dir.glob("*.md")):
        text = path.read_text(encoding="utf-8")
        front_matter, body = parse_front_matter(text)
        if front_matter.get("source") != "tweet":
            continue
        if front_matter.get("tweet_author") != args.author:
            continue
        if front_matter.get("tweet_posted_kind") == "repost":
            continue

        url = front_matter.get("tweet_url") or front_matter.get("source_url")
        tweet_id = front_matter.get("tweet_id", "") or tweet_id_from_url(url or "")
        date = tweet_date(tweet_id)
        if date is None or not (first_day <= date < range_end):
            continue

        tweet_text = extract_tweet_text(body, url)
        if not url or not tweet_text:
            continue

        candidates.append((date, int(tweet_id), tweet_text, url))

    last_date: dt.date | None = None
    for date, _tweet_id, tweet_text, url in sorted(candidates):
        if date != last_date:
            if last_date is not None:
                print()
            print(f"## {date.day:02d} de {SPANISH_MONTHS[date.month]} de {date.year}")
            print()
            last_date = date
        else:
            print()
            print("<p>❄ ❄ ❄ ❄ ❄</p>")
            print()

        print(blockquote(tweet_text))
        print()
        print(f'{{{{< tweet url="{url}" >}}}}')

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
