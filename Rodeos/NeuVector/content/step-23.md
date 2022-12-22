+++
title = "Create packet capture"
weight = 23
+++

Another handy feature is the easy creation of packet captures directly from the NeuVector UI to analyze the incoming and outgoing traffic of a Pod.

* Right click (double tap) on the WordPress Pod and choose **Packet capture**
* Click on the start (play) button
* Perform a few requests against [http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io](http://wordpress.${vminfo:Kubernetes01:public_ip}.sslip.io)
* Stop the packet capture
* Click on the **Generate download** button
* Download a PCAP file of this packet capture

You can now open this file in any tool that supports PCAP files, for example [Wireshark](https://www.wireshark.org/).
