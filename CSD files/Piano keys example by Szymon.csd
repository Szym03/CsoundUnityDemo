<Cabbage>
	hslider channel("filter_freq"), range(100, 20000, 440)
	hslider channel("reverb_size"), range(0,1, 0.5)
	hslider channel("amp"), range(0, 1, 0.5)
	checkbox channel("mute")
	combobox channel("shape"), items("triangle","saw")
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

giTri    ftgen     0, 0, 2^10, 10, 1, 0, -1/9, 0, 1/25, 0, -1/49, 0, 1/81
gisaw    ftgen 3, 0, 16384, 10, 0, .2, 0, .4, 0, .6, 0, .8, 0, 1, 0, .8, 0, .6, 0, .4, 0,.2

instr 1
	;Get CChannel info
	kamp chnget "amp"
	kfilter chnget "filter_freq" 
	kreverb chnget "reverb_size"
	kindex chnget "shape"
	kmute chnget "mute"

	;synth 
	kenv adsr 0.2, 0.1, 1, p3 - 0.3
	kfreq = mtof(p4)
	
	if kindex == 1 then
		asig oscil kenv, kfreq ,giTri, p3
	elseif kindex == 2 then
		asig oscil kenv, kfreq ,gisaw, p3
	endif
	
	
	;filter
	asigfilt lowpass2 asig, kfilter, 250
	
	;reverb
	asig1, asig2 freeverb asigfilt, asigfilt, kreverb, 0.3 
	
	;Out
	if kmute != 1 then
		asiglim1 limit asig1 ,0, 0.7
		asiglim2 limit asig2 ,0, 0.7
		outs asiglim1 * kamp, asiglim2 * kamp
	endif
	
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
