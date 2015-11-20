---
title: API
layout: rancher-default
---

## packetConfig


The configuration to launch an instance in Packet.

​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
apiKey | string | true | <no value> | <strong>required</strong> Your API key
billingCycle | string | false | <no value> | The billing cycle to use for Packet instances
facilityCode | string | false | <no value> | The region or facility code to launch packet
os | string | false | <no value> | The OS to install
plan | string | false | <no value> | The Packet server plan
projectId | string | true | <no value> | 

