try {
  Start-Transcript -Path .\pinger.log -Append -UseMinimalHeader
  while($true){
  <# Normal situation
    1     4 ms     1 ms     1 ms  192.168.1.1
    2     2 ms     4 ms     2 ms  80.223.32.2
    3     5 ms     5 ms     5 ms  141.208.193.10
    4     6 ms     6 ms     5 ms  10.14.166.25
    5     6 ms     5 ms     5 ms  195.165.31.12	
  #>
    $elapsed=Measure-Command{$output=(tracert -d -w 1000 195.165.31.12)}
    if($elapsed.TotalSeconds -gt 5){
        Write-Host (Get-Date -Format "d.M.yyyy HH\:mm") "tracert took" $elapsed.TotalSeconds.ToString("#.#") "seconds."
        Write-Host "Output was:" 
        $output
    }
    $elapsed=Measure-Command{
      try {
        [System.Net.DNS]::GetHostByName('none.sonera.fi')
      }catch{}
    }
    if($elapsed.TotalMilliSeconds -gt 100){
      Write-Host (Get-Date -Format "d.M.yyyy HH\:mm") "GetHostByName took" $elapsed.TotalMilliSeconds.ToString("#") "ms"
  }
  Start-Sleep 5
  }  
}
catch {}
finally {
  Stop-Transcript
}
