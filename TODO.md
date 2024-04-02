# Activate device
``` sql
When button clicked
    check connection state with device
    If connection is established
        Send message to characteristic to activate device {
            write to characteristic
        }

        Read from characteristic to get response {
            read from characteristic
        }

        if response is success
            change the color of the button
        else
            Display error message
    Else
        Display error message
```

# Scan device QR Code
- Add device to device list after scan
- Read device CO2 and attractif characteristic for info
- update device information