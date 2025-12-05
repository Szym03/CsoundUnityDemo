<Cabbage>
	form caption("My Synth")
	hslider channel("freq"), range(100, 2000, 440)
	hslider channel("amp"), range(0, 1, 0.5)
	checkbox channel("mute")
</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

giTri     ftgen     0, 0, 2^10, 10, 1, 0, -1/9, 0, 1/25, 0, -1/49, 0, 1/81

instr 1
	kamp = chnget("amp")
	
	kenv adsr 0.2, 0, 1, p3 - 0.2
	kfreq = mtof(p4)
	asig oscil kenv, kfreq ,giTri, p3
	
	outs asig, asig
endin

</CsInstruments>
<CsScore>
f0 z
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
