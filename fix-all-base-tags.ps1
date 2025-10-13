# Script para verificar e corrigir tags base em todos os arquivos HTML
Write-Host "=== VERIFICANDO E CORRIGINDO TAGS BASE ===" -ForegroundColor Green

# Lista de todos os arquivos HTML páginas completas
$files = @(
    "source\en-us\index_en-us.html",
    "source\en-us\pages\aboutus.html",
    "source\en-us\pages\bentonite.html",
    "source\en-us\pages\cleaningPad.html",
    "source\en-us\pages\connector.html",
    "source\en-us\pages\cushionPad.html",
    "source\en-us\pages\cutterAndBlade.html",
    "source\en-us\pages\derrick.html",
    "source\en-us\pages\directPushDrillRod.html",
    "source\en-us\pages\disposableDrillBit.html",
    "source\en-us\pages\drillBit.html",
    "source\en-us\pages\ep1000d.html",
    "source\en-us\pages\ep1000p.html",
    "source\en-us\pages\ep1000w.html",
    "source\en-us\pages\ep2000e.html",
    "source\en-us\pages\ep2000p.html",
    "source\en-us\pages\ep2000s.html",
    "source\en-us\pages\ep4000c.html",
    "source\en-us\pages\ep5100a.html",
    "source\en-us\pages\ep600w.html",
    "source\en-us\pages\ep800w.html",
    "source\en-us\pages\hollowAuger.html",
    "source\en-us\pages\maleAndFemaleCaps.html",
    "source\en-us\pages\monitoringWellPipe.html",
    "source\en-us\pages\percussionCap.html",
    "source\en-us\pages\products.html",
    "source\en-us\pages\pull-backCaps.html",
    "source\en-us\pages\quartzSand.html",
    "source\en-us\pages\redAndBlackCaps.html",
    "source\en-us\pages\samplingPipe.html",
    "source\en-us\pages\whitePipe.html",
    "source\pt-br\pages\aboutus.html",
    "source\pt-br\pages\bentonite.html",
    "source\pt-br\pages\cleaningPad.html",
    "source\pt-br\pages\connector.html",
    "source\pt-br\pages\cushionPad.html",
    "source\pt-br\pages\cutterAndBlade.html",
    "source\pt-br\pages\derrick.html",
    "source\pt-br\pages\directPushDrillRod.html",
    "source\pt-br\pages\disposableDrillBit.html",
    "source\pt-br\pages\drillBit.html",
    "source\pt-br\pages\ep1000d.html",
    "source\pt-br\pages\ep1000p.html",
    "source\pt-br\pages\ep1000w.html",
    "source\pt-br\pages\ep2000e.html",
    "source\pt-br\pages\ep2000p.html",
    "source\pt-br\pages\ep2000s.html",
    "source\pt-br\pages\ep4000c.html",
    "source\pt-br\pages\ep5100a.html",
    "source\pt-br\pages\ep600w.html",
    "source\pt-br\pages\ep800w.html",
    "source\pt-br\pages\hollowAuger.html",
    "source\pt-br\pages\maleAndFemaleCaps.html",
    "source\pt-br\pages\monitoringWellPipe.html",
    "source\pt-br\pages\percussionCap.html",
    "source\pt-br\pages\products.html",
    "source\pt-br\pages\pull-backCaps.html",
    "source\pt-br\pages\quartzSand.html",
    "source\pt-br\pages\redAndBlackCaps.html",
    "source\pt-br\pages\samplingPipe.html",
    "source\pt-br\pages\whitePipe.html"
)

$correctedCount = 0
$totalCount = $files.Count

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # Verificar se já tem tag base correta
        if ($content -match '<base href="/dev\.drillpush/">') {
            Write-Host "OK: $file já tem tag base correta" -ForegroundColor Gray
        }
        # Verificar se tem tag base incorreta para corrigir
        elseif ($content -match '<base href="/dev\.drillpush/">' -or $content -match '<base href="https://fluowen\.github\.io/dev\.drillpush/">' -or $content -like "*<base href*") {
            Write-Host "CORRIGINDO: $file - tag base incorreta" -ForegroundColor Yellow
            $content = $content -replace '<base href="[^"]*">', '<base href="/dev.drillpush/">'
            Set-Content $file -Value $content -NoNewline -Encoding UTF8
            $correctedCount++
        }
        # Se não tem tag base, adicionar após o título
        elseif ($content -match '<title>([^<]+)</title>') {
            Write-Host "ADICIONANDO: $file - sem tag base" -ForegroundColor Cyan
            $content = $content -replace '(<title>[^<]+</title>)', '$1' + "`n    <base href=`"/dev.drillpush/`">"
            Set-Content $file -Value $content -NoNewline -Encoding UTF8
            $correctedCount++
        }
    } else {
        Write-Host "ERRO: Arquivo não encontrado - $file" -ForegroundColor Red
    }
}

Write-Host "`n=== RESUMO ===" -ForegroundColor Green
Write-Host "Total de arquivos processados: $totalCount" -ForegroundColor Yellow
Write-Host "Arquivos corrigidos: $correctedCount" -ForegroundColor Yellow
Write-Host "Processo concluído!" -ForegroundColor Green