if (-not (Test-Path .venv)) {
    python -m venv .venv
}
& .\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
if (-not (Test-Path .env)) {
    Copy-Item .env.example .env
}
Write-Host "Projet local prepare. Configurer .env puis executer les scripts SQL MySQL."
