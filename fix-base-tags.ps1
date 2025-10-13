# Script para corrigir todas as tags base nos arquivos HTML
Write-Host "Iniciando correção das tags base..." -ForegroundColor Green

# Lista de arquivos que precisam ter a tag base descomentada e corrigida
$files = @(
    "source\pt-br\pages\bentonite.html",
    "source\pt-br\pages\cleaningPad.html", 
    "source\pt-br\pages\connector.html",
    "source\en-us\pages\bentonite.html",
    "source\en-us\pages\cleaningPad.html",
    "source\en-us\pages\connector.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processando: $file" -ForegroundColor Yellow
        
        # Ler o conteúdo do arquivo
        $content = Get-Content $file -Raw
        
        # Substituir a tag base comentada pela versão correta
        $content = $content -replace '<!--<base href="https://fluowen\.github\.io/dev\.drillpush/">', '<base href="/dev.drillpush/">'
        $content = $content -replace '-->', ''
        
        # Salvar o arquivo
        Set-Content $file -Value $content -NoNewline
        Write-Host "✓ Corrigido: $file" -ForegroundColor Green
    } else {
        Write-Host "✗ Arquivo não encontrado: $file" -ForegroundColor Red
    }
}

Write-Host "Correção concluída!" -ForegroundColor Green