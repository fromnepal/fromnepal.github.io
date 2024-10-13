Get-Date;
# Define the directory containing HEIC files
$sourceDir = "C:\Users\kushal\Pictures\heic"
# Define the directory to save PNG files
$destDir = "C:\Users\kushal\Pictures\print-2024-10-13"

# Create the destination directory if it doesn't exist
if (!(Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir
}

# Get all HEIC files in the source directory
$heicFiles = Get-ChildItem -Path $sourceDir -Filter *.heic

foreach ($file in $heicFiles) {
    # Define the output file path
    $outputFile = Join-Path -Path $destDir -ChildPath ($file.BaseName + ".png")
    
    # Convert HEIC to PNG using ImageMagick
    magick "$($file.FullName)" "$outputFile"
    
    # Copy metadata from HEIC to PNG
    magick mogrify -profile "$($file.FullName)" "$outputFile"
}

Write-Output "Conversion complete!"
Get-Date;
