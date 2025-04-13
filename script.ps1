# Push-Commits.ps1

# --- Configuração ---
$remoteName = "origin"
$branchName = "main"
# ------------------

Write-Host "Verificando commits locais para enviar para $remoteName/$branchName..."

# Pega a lista de hashes dos commits locais que não estão no remoto (do mais antigo para o mais novo)
$commitsToPush = git log --reverse --pretty=format:"%H" "$($remoteName)/$($branchName)..HEAD"

if (-not $commitsToPush) {
    Write-Host "Nenhum commit local para enviar. O branch já está atualizado."
    exit 0
}

$commitList = $commitsToPush -split '\r?\n'
$totalCommits = $commitList.Length
Write-Host "Encontrados $totalCommits commits locais para enviar."

$i = 1
foreach ($commitHash in $commitList) {
    Write-Host "Tentando push do commit [$i/$totalCommits]: $commitHash ..."
    # Tenta fazer push do commit atual para o branch remoto
    git push $remoteName "$($commitHash):refs/heads/$($branchName)"

    # Verifica se o push foi bem-sucedido
    if ($LASTEXITCODE -ne 0) {
        Write-Error "ERRO: Falha ao fazer push do commit $commitHash. Abortando."
        Write-Error "Verifique a mensagem de erro acima. Resolva o problema e tente novamente."
        # Você pode querer remover commits locais problemáticos ou tentar outras soluções.
        exit 1
    } else {
        Write-Host "Commit $commitHash enviado com sucesso!"
    }
    $i++
}

Write-Host "Todos os $totalCommits commits locais foram enviados com sucesso para $remoteName/$branchName."
exit 0