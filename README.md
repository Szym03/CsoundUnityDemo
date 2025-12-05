# CsoundUnity: Getting Started Guide

*Procedural Audio Synthesis for Unity*



## What is CsoundUnity?

CsoundUnity integrates Csound, a powerful audio synthesis language, into Unity. It creates Csound-based AudioSource objects for procedural audio, real-time synthesis, and advanced sound processing.



## Installation

1. In Unity: **Window → Package Manager → + → Add package from git URL**
2. Paste: `https://github.com/rorywalsh/CsoundUnity.git`



## Basic Setup

1. Create a GameObject, add the **CsoundUnity** component
2. Drag a `.csd` file into the **Csd Asset** field (AudioSource added automatically)



## Controlling Csound from the Editor

CsoundUnity generates Inspector widgets for any channels defined in a `<Cabbage>` section at the top of your `.csd`:

```csound
<Cabbage>
form caption("My Synth")
hslider channel("freq"), range(100, 2000, 440)
hslider channel("amp"), range(0, 1, 0.5)
checkbox channel("mute")
</Cabbage>
```

**Supported widgets:** `hslider`, `vslider`, `rslider` (sliders), `button`, `checkbox`, `combobox`

- Each widget needs a `channel()`
- Sliders also need `range(min, max, default)`



## Controlling Csound from Scripts

Get a reference to CsoundUnity and wait for initialization before calling methods:

```csharp
CsoundUnity csound;

void Start() => csound = GetComponent<CsoundUnity>();

void Update() 
{
    if (!csound.IsInitialized) return;
    csound.SetChannel("speed", velocity.magnitude);
}
```

In your Csound instrument, read the channel with `chnget`:

```csound
kSpeed chnget "speed"
```



## Starting & Stopping Instruments

Use `SendScoreEvent()` to trigger instruments with standard Csound score syntax:

```csharp
csound.SendScoreEvent("i1 0 10");  // start instr 1 now, play 10 sec
csound.SendScoreEvent("i1 0 -1");  // start with indefinite duration
csound.SendScoreEvent("i-1 0 -1"); // stop instrument 1
```



## Keeping Csound Running

**Important:** Csound stops when all instruments finish. Add this to your score section to keep it alive:

```csound
<CsScore>
f0 z   ; keeps Csound running indefinitely
</CsScore>
```

## References

- [CsoundUnity Documentation](https://rorywalsh.github.io/CsoundUnity/)
- [CsoundUnity GitHub Repository](https://github.com/rorywalsh/CsoundUnity)
- [My in-class demo Unity project](https://github.com/Szym03/CsoundUnityDemo)
- [Csound Official Website](https://csound.com/)
# CsoundUnityDemo
