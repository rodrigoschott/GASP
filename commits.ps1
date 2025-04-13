# AutoCommitByDirectory.ps1

# Certifique-se de que .gitignore e .gitattributes já foram commitados!

Write-Host "Iniciando commits automáticos por diretório..."

# Garante que estamos no diretório raiz do Git
$gitRoot = git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0) {
    Write-Error "ERRO: Não parece estar em um repositório Git. Abortando."
    exit 1
}
cd $gitRoot

# Função para fazer add e commit
function Commit-Group($filesToAdd, $commitMessage) {
    if ($filesToAdd.Count -eq 0) {
        return
    }
    Write-Host "Adicionando $($filesToAdd.Count) arquivos para commit: $commitMessage"
    # Adiciona arquivos específicos para evitar problemas com caminhos longos/especiais
    $filesToAdd | ForEach-Object { git add -- "$_" }

    # Verifica se algo foi realmente staged (git add pode não adicionar nada se já estiver atualizado)
    $stagedFiles = git diff --name-only --cached
    if ($stagedFiles) {
        Write-Host "Fazendo commit..."
        git commit -m $commitMessage
        if ($LASTEXITCODE -ne 0) {
            Write-Error "ERRO: Falha ao fazer commit para '$commitMessage'. Verifique os erros."
            # Decide se quer parar ou continuar com outros diretórios
            # exit 1 # Descomente para parar no primeiro erro de commit
        }
    } else {
        Write-Host "Nenhum arquivo novo foi adicionado ao stage para este grupo."
    }
}

# Pega todos os arquivos modificados e não rastreados (respeitando .gitignore)
# Usa --porcelain=v1 para um formato estável
$statusLines = git status --porcelain=v1

if (-not $statusLines) {
    Write-Host "Nenhuma alteração para commitar."
    exit 0
}

$filesByGroup = @{}

foreach ($line in $statusLines) {
    $status = $line.Substring(0, 2).Trim()
    $filePath = $line.Substring(3) # Remove os 2 caracteres de status e o espaço

    # Ignora arquivos deletados no status para este script simples
    if ($status -eq 'D' -or $status -eq ' D') { continue }

    # Remove aspas se existirem (para nomes com espaços)
    if ($filePath.StartsWith('"') -and $filePath.EndsWith('"')) {
        $filePath = $filePath.Substring(1, $filePath.Length - 2)
    }

    # Determina o grupo (diretório de primeiro nível ou raiz)
    $groupName = "." # Arquivo na raiz
    if ($filePath -match '[\\/]') {
         # Pega a primeira parte do caminho antes da primeira barra/contra-barra
        $groupName = ($filePath -split '[\\/]', 2)[0]
    }

    # Inicializa o grupo se não existir
    if (-not $filesByGroup.ContainsKey($groupName)) {
        $filesByGroup[$groupName] = [System.Collections.Generic.List[string]]::new()
    }

    # Adiciona o arquivo ao grupo
    $filesByGroup[$groupName].Add($filePath)
}

# Processa cada grupo
foreach ($group in $filesByGroup.Keys) {
    $commitMessage = "Auto-commit: Modificações em $group"
    if ($group -eq ".") {
        $commitMessage = "Auto-commit: Modificações na raiz do projeto"
    }
    Commit-Group $filesByGroup[$group] $commitMessage
}

Write-Host "Processo de commit automático por diretório concluído."
Write-Host "Verifique os commits com 'git log' e tente 'git push origin main'."
Write-Host "Se o push falhar, considere usar o script Push-Commits.ps1 para enviar um por um."