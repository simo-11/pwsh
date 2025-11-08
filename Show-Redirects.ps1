param (
    [Parameter(Mandatory = $true)]
    [string]$Uri
)

# Initial URL
$url = $Uri
$maxRedirects = 10
$redirects = 0
$history = @()

while ($true) {
    $request = [System.Net.HttpWebRequest]::Create($url)
    $request.Method = "GET"
    $request.AllowAutoRedirect = $false

    $response = $request.GetResponse()
    $headers = $response.Headers
    $status = [int]$response.StatusCode
    $location = $headers["Location"]
    $length = $headers["Content-Length"]
    $type = $headers["Content-Type"]
    $response.Close()

    if ($status -ge 300 -and $status -lt 400 -and $location) {
        Write-Host "➡️  ${status}: $url → $location"
        $history += "${status}: $url → $location"
        $url = $location
        $redirects++

        if ($redirects -ge $maxRedirects) {
            Write-Warning "⚠️  Max redirects ($maxRedirects) reached."
            break
        }
    } else {
        Write-Host "✅ Final GET response: $url"
        Write-Host "Status code: ${status}"
        Write-Host "Content-Type: $type"
        Write-Host "Content-Length: $length"
        break
    }
}

# Print redirect history
Write-Host "`n📜 Redirect history:"
$history | ForEach-Object { Write-Host $_ }
