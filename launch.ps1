

# PowerShell
#  .\launch.ps1

# project to builds
$projects=@(
"C:\work\dev\project1",
"C:\work\dev\project2\under-project1",
"C:\work\dev\project2\under-project2",
"C:\work\dev\project3\under-project1"
)

& .\scriptChainedBuild.ps1 $projects
