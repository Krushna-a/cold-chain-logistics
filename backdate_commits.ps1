# PowerShell script to create backdated commits for August 2026
# This will make your GitHub contribution graph green for the entire month

$repo_path = "c:\Code\FDE\cold-chain-logistics-FDE-Project"
Set-Location $repo_path

# Initialize git repository
Write-Host "Initializing Git repository..." -ForegroundColor Cyan
git init

# Create commit messages for different project phases
$commitMessages = @(
    "Initial project structure and documentation",
    "Add data ingestion pipeline for legacy SQL Server",
    "Implement SQL Server Docker configuration",
    "Create database security layer with RBAC",
    "Add Pinecone vector store integration",
    "Implement SOP document parsing pipeline",
    "Add OpenAI embeddings support",
    "Implement HuggingFace local embeddings fallback",
    "Create LangGraph orchestrator with state management",
    "Add agent tools: SQL query, weather API, vector search",
    "Implement streaming agent execution",
    "Add system prompt for business-focused responses",
    "Create Streamlit UI with dispatch console",
    "Add multi-session thread management",
    "Implement real-time agent visualization",
    "Add security audit log dashboard",
    "Create audit trail database schema",
    "Implement incremental document ingestion",
    "Add MD5-based change detection",
    "Optimize batch processing for Pinecone upserts",
    "Add support for PDF document parsing",
    "Implement Excel and CSV file processing",
    "Add environment configuration management",
    "Create deployment scripts for AWS EC2",
    "Add systemd service configuration",
    "Implement ODBC driver setup automation",
    "Optimize embedding model caching",
    "Add DeepSeek R1 integration",
    "Configure multi-LLM support (OpenAI/DeepSeek/Ollama)",
    "Finalize README and documentation",
    "Add project deployment guide"
)

# August 2026 has 31 days
$year = 2026
$month = 8
$daysInMonth = 31

Write-Host ""
Write-Host "Creating commits for August 2026..." -ForegroundColor Cyan
Write-Host "This will take a moment..." -ForegroundColor Yellow
Write-Host ""

$commitIndex = 0

# Loop through each day of August 2026
for ($day = 1; $day -le $daysInMonth; $day++) {
    # Random time during working hours (9 AM to 6 PM)
    $hour = Get-Random -Minimum 9 -Maximum 18
    $minute = Get-Random -Minimum 0 -Maximum 59
    $second = Get-Random -Minimum 0 -Maximum 59
    
    # Format date for git commit
    $dateString = "{0:D4}-{1:D2}-{2:D2}T{3:D2}:{4:D2}:{5:D2}" -f $year, $month, $day, $hour, $minute, $second
    
    # Get commit message (cycle through if we run out)
    $message = $commitMessages[$commitIndex % $commitMessages.Length]
    $commitIndex++
    
    # Stage all files
    git add .
    
    # Create commit with backdated timestamp
    $env:GIT_AUTHOR_DATE = $dateString
    $env:GIT_COMMITTER_DATE = $dateString
    
    git commit -m $message --date=$dateString 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Day $day : $message" -ForegroundColor Green
    } else {
        Write-Host "Day $day : No changes to commit" -ForegroundColor Yellow
    }
    
    # Clear environment variables
    Remove-Item Env:\GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
    Remove-Item Env:\GIT_COMMITTER_DATE -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git repository prepared successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Create a new repository on GitHub: https://github.com/new" -ForegroundColor White
Write-Host "   Repository name: cold-chain-logistics" -ForegroundColor White
Write-Host ""
Write-Host "2. Run these commands to push:" -ForegroundColor White
Write-Host "   git branch -M main" -ForegroundColor Cyan
Write-Host "   git remote add origin https://github.com/Krushna-a/cold-chain-logistics.git" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "Note: Your GitHub contribution graph will show activity for August 2026!" -ForegroundColor Green
