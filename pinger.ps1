while($true){
    $elapsed=Measure-Command{tracert -d -w 1000 10.20.224.1}
    if($elapsed.TotalSeconds -gt 5){
        Write-Host (Get-Date -Format "d.M.yyyy HH\:mm") ": tracert took " $elapsed.TotalSeconds.ToString("#.#") "seconds."
    }
    Start-Sleep 5
}