[cmdletbinding()]
Param(
    [parameter(Mandatory=$true)]
    [alias("j")]
    [string]$ProposedOrderRequestBody
    )
function Add-Error([string]$message) {
    Write-Host $message -ForegroundColor Red
    $global:Formaterror = $true
}

function Add-Warning([string]$msg){
    Write-Host $msg -Foreground Yellow
    $global:formatError = $true
}
try {
    $parsed = $ProposedOrderRequestBody | ConvertFrom-Json
} catch {
    Write-Host "Error while parsing request body as JSON"
    throw
}

$Global:Formaterror = $false
$proposedOrderBody = $parsed.proposed_order


if($proposedOrderBody.payment_token_data -eq $null) {
    Add-Error "Payment token data is required but not present!"
}

if($proposedOrderBody.payment_token_data.GetType().Name -ne [String].Name){
    Add-Error "Payment token data `"$propsedOrderBody.payment_token_data`" is not a string!"
}


if($proposedOrderBody.location_id -eq $null) {
    Add-Error "Location id is required but not present!"
}

if($proposedOrderBody.location_id.GetType().Name -ne [Int32].Name){
    Add-Error "Location Id `"$propsedOrderBody.location_id`" is not an integer!"
}

if($proposedOrderBody.items.count -eq 0) {
    Add-Error "No items!!"
}

foreach($item in $proposedOrderBody.items) {
$current = $item.item
    if($current.standard_price_amount -eq $null) {
        Add-Error ("{0} Standard price amount is not present!" -f $current.name)
        }
    if($current.standard_price_amount.GetType().Name -ne [Int32].Name) {
        Add-Error "Standard price amount is not an integer!"
        }
    if($current.charged_price_amount -eq $null) {
        Add-Error ("Charged price amount for item named `"{0}`" is not present!" -f $current.name) 
        }
    if($current.charged_price_amount.GetType().Name -ne [Int32].Name) {
        Add-Error "Charged Price amount is not an integer!"
        }
    if($current.charged_price_amount -ne $current.standard_price_amount) {
        Add-Warning ("{0} Charge Price Amount ({1}) and Standard Price Amount ({2}) are not the same!" -f $current.name, $current.charged_price_amount, $current.standard_price_amount)
        }
  
    if($current.sku -eq $null) {
        Add-Error "SKU is not present!"
        }
    }


if(!$Global:Formaterror) {
    Write-Host -ForegroundColor Green "Proposed order request is valid!"
}