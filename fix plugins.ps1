dir plugins -r -filter "Functions.cpp" | % {
	if ($_.Name -cne $_.Name.ToLower()) {
		ren $_.FullName $_.Name.ToLower()
		Write-Host $_.Name
	}
}
dir plugins -r -filter "Parameters.cpp" | % {
	if ($_.Name -cne $_.Name.ToLower()) {
		ren $_.FullName $_.Name.ToLower()
		Write-Host $_.Name
	}
}
Read-Host -Prompt "Press Enter to exit"