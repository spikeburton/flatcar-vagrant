# Running Flatcar Container Linux with Vagrant

This repository simplifies the process of configuring a cluster of virtual machines running Flatcar Container Linux using Vagrant. To get started, simply run the following command:

```sh
sh init.sh
```

This will create a Vagrant box using the `stable` channel of Flatcar. If you wish, you can modify the `CHANNEL` variable in the script to use `alpha`, `beta` or `stable`. All files necessary to create the box will be downloaded into a folder in the current working directory called `config`.

Feel free to use the provided Vagrantfile as is, or create your own by running `vagrant init flatcar-stable`, substituting the name of your box if using a different release channel.
