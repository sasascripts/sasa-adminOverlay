function CheckForUpdate()
    local url = "https://api.github.com/repos/sasascripts/sasa-adminOverlay/releases/latest"
    PerformHttpRequest(url, function(status, response, headers)
        if status == 200 then
            local releaseData = json.decode(response)
            local latestVersion = releaseData.tag_name

            if latestVersion > Config.Version then
                print("A new version is available: " .. latestVersion)
                print("Your current version: " .. Config.Version)
                print("Update is recommended for better features and fixes.")
            else
                print("You are using the latest version: " .. Config.Version)
            end
        else
            print("Failed to check for updates.")
        end
    end, "GET", "")
end

function PrintServerInfo()
    print("SASA-ADMINOVERLAY")
    print("Current version: " .. Config.Version)
    CheckForUpdate()
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        PrintServerInfo()
    end
end)