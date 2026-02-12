"use strict";

(() => {
  const internalHosts = new Set([
    window.location.hostname,
    "domingogallardo.site",
    "www.domingogallardo.site",
    "localhost",
    "127.0.0.1",
  ]);

  const anchors = document.querySelectorAll("a[href]");

  for (const a of anchors) {
    const href = (a.getAttribute("href") || "").trim();
    if (!href) continue;

    if (
      href.startsWith("#") ||
      href.startsWith("mailto:") ||
      href.startsWith("tel:") ||
      href.startsWith("javascript:")
    ) {
      continue;
    }

    let url;
    try {
      url = new URL(href, window.location.origin);
    } catch {
      continue;
    }

    if (url.protocol !== "http:" && url.protocol !== "https:") continue;

    if (!internalHosts.has(url.hostname)) {
      a.setAttribute("target", "_blank");

      const rel = new Set((a.getAttribute("rel") || "").split(/\s+/).filter(Boolean));
      rel.add("noopener");
      rel.add("noreferrer");
      a.setAttribute("rel", Array.from(rel).join(" "));
    }
  }
})();
