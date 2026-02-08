const canvas  = document.getElementById("canvas");
const ctx     = canvas.getContext("2d");

const radius  = 15;
let   x       = canvas.width  / 2;
let   y       = canvas.height / 2;

const speed = 6;  // Velocidad constante

// Generar un ángulo aleatorio entre 0 y 2π radianes
const angle = Math.random() * 2 * Math.PI;

// Calcular las componentes de la velocidad
let dx = speed * Math.cos(angle);
let dy = speed * Math.sin(angle);

function drawBall() {
  ctx.beginPath();
  ctx.arc(x, y, radius, 0, Math.PI * 2);
  ctx.fillStyle = "#f5c518";
  ctx.fill();
  ctx.closePath();
}

function update() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  drawBall();

  // Rebote contra las paredes
  if (x + dx > canvas.width  - radius || x + dx < radius) dx = -dx;
  if (y + dy > canvas.height - radius || y + dy < radius) dy = -dy;

  x += dx;
  y += dy;

  requestAnimationFrame(update);
}

update();