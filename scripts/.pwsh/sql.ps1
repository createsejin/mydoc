$sql = "C:\Users\creat\AppData\Local\TheCave\sql"

<# 
.mode box --wrap 30 -ww
.width 0 23 5 0 45 30
OutputMode @#logger#>
function GetTimeStamp {
  param (
    [int]$hour,
    [int]$minute,
    [int]$second
  )
  $today = Get-Date
  $date_time = $today.Date.AddHours($hour).AddMinutes($minute).AddSeconds($second)
  $formatted_time_stamp = $date_time.ToString("yyyy-MM-ddTHH:mm:ss.fff")
  return $formatted_time_stamp
}

function SelectAfterTime {
  param (
    [string]$time
  )
  Clear-Content $sql
  $select_down_log_query = ".mode box --wrap 30 -ww
.width 0 0 23 5 0 100
SELECT row_number() over (order by Timestamp) as row, id, 
  Timestamp, Level, Exception, RenderedMessage
FROM (
  SELECT * FROM downloader_log
  union
  SELECT * FROM operator_log
  union
  SELECT * FROM login_log
)
WHERE Timestamp >= '$time'
ORDER BY Timestamp;"
  Set-Content $sql -Value $select_down_log_query
  Get-Content $sql
}

if ($args[0] -ieq "q") {
  if (($args[1] -is [int]) -and ($args[2] -is [int])) {
    if ($args[3] -is [int]) {
      $time_stamp = GetTimeStamp -hour $args[1] -minute $args[2] -second $args[3]
    }
    else {
      $time_stamp = GetTimeStamp -hour $args[1] -minute $args[2]
    }
    # Write-Output $time_stamp
    SelectAfterTime -time $time_stamp
  }
}
<#  
SqlScript @#logger#>
