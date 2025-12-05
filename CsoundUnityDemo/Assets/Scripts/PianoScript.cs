using UnityEngine;

/// Sends Csound score events when keyboard keys are pressed.
/// Attach this script to the same GameObject as your CsoundUnity component.

public class CsoundKeyboardPlayer : MonoBehaviour
{
    private CsoundUnity csound;
    
    // Map keys to MIDI note numbers (C4 = 60)
    private readonly KeyCode[] keys = {
        KeyCode.A,  // C
        KeyCode.W,  // C#
        KeyCode.S,  // D
        KeyCode.E,  // D#
        KeyCode.D,  // E
        KeyCode.F,  // F
        KeyCode.T,  // F#
        KeyCode.G,  // G
        KeyCode.Y,  // G#
        KeyCode.H,  // A
        KeyCode.U,  // A#
        KeyCode.J,  // B
        KeyCode.K   // C 
    };
    
    [Tooltip("Base MIDI note number (60 = C4)")]
    public int baseNote = 60;

    void Start()
    {
        csound = GetComponent<CsoundUnity>();

    }

    void Update()
    {
        if (csound == null || !csound.IsInitialized) return;
        
        for (int i = 0; i < keys.Length; i++)
        {
            if (Input.GetKeyDown(keys[i]))
            {
                PlayNote(baseNote + i);
            }
        }
        
        // Octave shift with Z and X
        if (Input.GetKeyDown(KeyCode.Z)) baseNote -= 12;
        if (Input.GetKeyDown(KeyCode.X)) baseNote += 12;
    }
    
    void PlayNote(int midiNote)
    {
        csound.SendScoreEvent($"i1 0 0.8 {midiNote}");
    }
}