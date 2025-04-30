<p align="center">
    <img width="300" height="300" src="https://github.com/user-attachments/assets/cfe5e7f7-a190-4c62-aafd-4d370138e4aa">

</p>


<h1 align="center">🚀 Rider Launch Godot Plugin 🔌</h1>
<p align="center">
    <a href="https://godotengine.org/download/archive/4.3-stable/"> 
        <img src="https://img.shields.io/badge/Godot%204--3-Godot%204--3?style=for-the-badge&logo=godot-engine&logoColor=white&label=Godot%20version&color=26476D">
    </a>
</p>

<p align="center">
 <img src="https://i.ibb.co/R4C47nzp/0430.gif">
</p>

> **NOTE :** if you want to help us and/or participate on improving this plugin don't hesitate to open a PR 📥

A plugin for [Godot Engine](https://github.com/godotengine/godot) written fully in [GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html), that lets you launch a **JetBrains Rider** configuration directly from Godo

⚠️ Beware !! You will need to have [Expose Run/Debug ](https://plugins.jetbrains.com/plugin/27239-expose-run-debug?noRedirect=true) Jetbrain Rider Plugin installed on your Rider IDE. ⚠️

<p align="center">
    <img src="">
</p>

## 📃 How to use it

1 - **Clone the repository** or download the `.zip` file and unzip it:
git clone https://github.com/Meta-Ben/RiderLaunchPlugin

2 - Move the **RiderLaunchPlugin** folder into the `addons` directory of your Godot project. If the folder doesn’t exist, create it.

3 - In Godot, navigate to `Project -> Project Settings -> Plugins`, then enable the plugin **RiderLaunchPlugin**.

4 - After enabling the plugin, you should notice .. Nothing 😛, cause this plugin replace the actual play button 

5 - But under `Editor -> Editor Settings -> General -> Rider launcher` you should have configurable parameters ! ( all should be setup as the same as the defaults config for [Expose Run/Debug ](https://plugins.jetbrains.com/plugin/27239-expose-run-debug?noRedirect=true), you can do modifications, but they should match with you're Rider configuration

<p align="center">
    <img src="https://i.ibb.co/LT8jtNr/Capture-d-e-cran-2025-04-30-a-17-20-00.png">
</p>

6 - Check the expose run/debug plugin settings in rider, the port should match 

<p align="center">
    <img src="https://i.ibb.co/rRGzy85x/Capture-d-e-cran-2025-04-30-a-17-20-30.png">
</p>

7 - Check the run/debug config name in rider it should aslo match

<p align="center">
    <img src="https://i.ibb.co/x87s9qbL/Capture-d-e-cran-2025-04-30-a-17-20-41.png">
</p>

8 - Then press play button on Godot, this should launch your project as normal, but Rider should start monitoring the code too !  🎉

<p align="center">
    You should see this in Rider IDE : <img src="https://i.ibb.co/8DjL2FVm/Capture-d-e-cran-2025-04-30-a-17-20-56.png">
</p>


## ⚙️ Configuration documentation

`Base Url` -> Its the IP address of the Rider IDE instance you want to target ( localhost or 127.0.0.1 by default since you mainly want to target your own machine )

`Port` -> Its the port of the Rider IDE instance you want to target ( ⚠️ this should match the exposing port in the [Expose Run/Debug ](https://plugins.jetbrains.com/plugin/27239-expose-run-debug?noRedirect=true) plugin settings of your Rider IDE )

`Execution Type` -> Its the type of execution you want ( Officialy only debug is available for godot in GDScript, but run is also available for C# )

`Config to Execute` -> Its the name of the run/debug config you want to execute ( by default its Player GDScript, because its the one Rider with the Godot plugin set, but it can be changed, like the port it should match on both side )
 
