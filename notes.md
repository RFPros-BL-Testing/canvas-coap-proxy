```
{
    "WirelessDeviceList": [
        {
            "Arn": "arn:aws:iotwireless:us-east-1:985151167101:WirelessDevice/5ef2eaab-89d5-458d-9371-4d99851cd422",
            "Id": "5ef2eaab-89d5-458d-9371-4d99851cd422",
            "Type": "CoAP",
            "Name": "MyCoapDevice",
            "DestinationName": "coaphelloworld_CoAPDestination_node",
            "Cellular": {
                "Imei": "9956798246756221"
            },
            "WiFi": {
                "MacAddress": "995679824675"
            }
        }
    ]
}

list-wireless-devices
{
  "WirelessDeviceId": "ed8d199f-9ab1-4a5d-8df9-198c8b39952c",
  "PayloadData": "dGVzdA==",
  "WirelessMetadata": {
    "CoAP": {
      "RequestMethod": "PUT",
      "ResponseToken": "0c22709f-5c65-42f5-af16-1f15d20b7bf1",
      "UriPath": [
        "telemetry"
      ]
    }
  }
}
```

get-wireless-device
