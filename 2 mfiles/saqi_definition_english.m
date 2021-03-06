% =========================================================================
% Copyright (c) 2008-2014 Audio Communication Group, TU Berlin
% 
% This file is part of WhisPER, a package of interacting MATLAB scripts for 
% designing and controlling experiments in the field of auditory perceptive 
% measurement and evaluation.
% 
% WhisPER is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option) 
% any later version. 
% 
% WhisPER is distributed in the hope that it will be useful, but WITHOUT ANY 
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
% FOR A PARTICULAR PURPOSE.
% See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see <http://www.gnu.org/licenses/>. 
% 
% http://www.ak.tu-berlin.de/whisper/ 
% =========================================================================
% 
% This file:
%
% Author :   Martina Vrhovnik and Fabian Brinkmann,
%            Audio Communication Group, TU Berlin
% Email  :   fabian.brinkmann at tu-berlin dot de
% Date   :   Oct. 2013
% Updated: 
%             
% =========================================================================

SAQI_definition = ...
    {...
    1 'Existence of a noticeable difference.';...
    2 'Timbral impression which is determined by the ratio of high to low frequency components.';...
    3 'Timbral change in a limited frequency range.';...
    4 'Timbral change in a limited frequency range.';...
    5 'Timbral change in a limited frequency range.';...
    6 {'Timbral impression which e.g., is indicative for the force with which a sound source is excited.'; ...
      'Example:' 
      '- Hard/soft beating of percussion instruments.';... 
      '- Hard/soft plucking of string instruments (classic guitar, harp).'; ...
      '- Emphasized high frequencies may promote a "sharp" sound impression.'};...
    7 {'Timbral impression of fierce or aggressive modulation/vibration, whereas individual oscillations are hardly distinguishable.'; ...
      'Often rated as unpleasant.'};...
    8 {'Often perceived as tonal coloration. "Hollow" sound.'; ...
      'Example: Speaking through a tube.'};...
    9 {'Coloration with pronounced narrow-band resonances, often as a result of low density of natural frequencies.';...
      'Often heard when exciting metallic objects such as gongs, bells, tin cans.'; ...
      'Applicable to room simulations, plate reverb, spring reverb, too.'};...
    10 {'Perceptibility of a pitch in a sound.'; ...
       'Example for tonal sounds: voiced speech, beeps'};...      
    11 'The perception of pitch allows arranging tonal signals along a scale "higher - lower".';...
    12 {'Continuous change of pitch. Often perceived as a "continuous detuning".'; ...
       'Example: "Detuned" sound of the siren of a fast-moving ambulance.'};...
    13 'Direction of a sound source in the horizontal plane.';...
    14 'Direction of a sound source in the vertical plane.';...
    15 {'Refers to the position of a sound source before or behind the listener only.'; ...
       'Impression of a position difference of a sound source caused by "reflecting" its position on the frontal plane going through the listener.'};...
    16 'Perceived distance of a sound source.';...
    17 'Perceived extent of a sound source in radial direction.';...
    18 'Perceived extent of a sound source in horizontal direction.';...
    19 'Perceived extent of a sound source in vertical direction.';...
    20 {'Describes the distinctness with which a sound source is perceived within or outside the head regardless of their distance.'; ...
       'Terminologically often enclosed between the phenomena of in-head localization and out-of-head localization.'; ...
       'Examples:';... 
       '- Poorly/not externalized = Perceived position of sound sources at diotic sound presentation via headphones.';... 
       '- Good/strongly externalized = Perceived position of a natural source in reverberant environment and when allowing for movements of the listener.'};...
    21 {'If localizability is low, spatial extent and location of a sound source are difficult to estimate, or appear diffuse, resp.';... 
       'If localizability is high, a sound source is clearly delimited. Low/high localizability is often associated with high/low perceived extent of a sound source.';... 
       'Examples: sound sources in highly diffuse sound field are poorly localizable.'};...
    22 {'Sound sources, which - by experience - should have a united spatial shape, appear spatially separated.' ;...
       'Possible cause: Parts of the sound source have been synthesized/simulated using separated algorithms/simulation methods and between those exists an unwanted offset in spatial parameters.';... 
       'Examples:' ;...
       '- Fingering noise and playing tones of an instrument appear at different positions.';... 
       '- Spirant and voiced phonemes of speech are synthesized separately and then reproduced with an unwanted spatial separation.'};...
    23 {'Perception of a strong reverberant sound field, caused by a high ratio of reflected to direct sound energy.' ;...
       'Leads to the impression of high diffusivity in case of stationary excitation (in the sense of a low D/R-ratio).';... 
       'Example: The perceived intensity of reverberation differs significantly between rather small and very large spaces, such as living rooms and churches.'};...
    24 'Duration of the reverberant decay. Well audible at the end of signals.';...
    25 {'Sensation of being spatially surrounded by the reverberation. With more pronounced envelopment of reverberation, it is increasingly difficult to assign a specific position, a limited extension or a preferred direction to the reverberation.';... 
       'Impressions of either low or high reverberation envelopment arise with either diotic or dichotic (i.e., uncorrelated) presentation of reverberant audio material.'};... 
    26 'Copies of a sound with mostly lower loudness prior to the actually intended the starting point of a sound.';...
    27 {'Copies of a sound with mostly decreasing loudness after the actually intended the starting point of a sound.';... 
       'Example: Repetition of one''s own voice through reflection on mountain walls'};...
    28 {'Sound sources, which - by experience - should have a united temporal shape, appear temporally separated.';... 
       'Causes similar to "spatial disintegration", however, here: due to timing-offsets in synthesis.' ;...
       'Example: Fingering noise and playing tones of an instrument appear at different points in time.'};...
    29 {'Characteristic which is affected by the impulse fidelity of systems. Perception of the reproduction of transients. Transients can either be more soft/more smoothed/less precise, or - as opposed -  be quicker/more precise/ more exact.';... 
       'Example for "smoothed" transients:';...
       'A transmission system that exhibits strong group delay distortions.';... 
       'Counter-example:';... 
       'Result of an equalization aiming at phase linearization.'};...
    30 {'A scene is identical in content and sound, but evolves faster or slower. Does not have to be accompanied by a change in pitch.';... 
       'Examples of technical reasons:';... 
       '- rotation speed' ;...
       '- sample rate conversion';... 
       '- time stretching' ;...
       '- changed duration of pauses between signal starting points';... 
       '- movements proceed at a different speed'};...
    31 {'Order or occurrence of scene components.';... 
       'Example: A dog suddenly barks at the end, instead - and as opposed to the reference - at the beginning.'};...
    32 'Characteristic that is affected by latencies in the reproduction system. Distinguishes between more or less delayed reactions of a reproduction system with respect to user interactions.';...
    33 {'Perceived loudness of a sound source. Disappearance of a sound source can be stated by a loudness equaling zero.';... 
       'Example of a loudness contrast: whispering vs. screaming'};...
    34 'Amount of loudness differences between loud and soft passages. In signals with a smaller dynamic range loud and soft passages differ less from the average loudness. Signals with a larger dynamic range contain both very loud and very soft passages.';...
    35 {'Sound changes beyond the long-term loudness. Collective category for a variety of percepts caused by dynamic compression.' 
        'Examples:' 
        '- More compact sound of sum-compressed music tracks in comparison to the unedited original.' 
        '- "Compressor pumping": Energy peaks in audio signals (bass drums, speech plosives) lead to a sudden drop in signal loudness which needs a susceptible period of time to recover.'};...
    36 {'Perception of a clearly unintended sound event.';... 
       'For example, a disturbing tone which is clearly not associated with the presented scene, such as an unexpected beep.'};...
    37 {'Perception of a clearly unintended sound event.' ;...
       'For example, a short disturbing sound which is clearly not associated with the presented scene, such as an unexpected click.'};...
    38 {'Perception of a clearly unintended sound event.';... 
       'For example, a noise which is clearly not associated with the presented scene, such as a background noise from of a fan.'};...
    39 {'Perception of a clearly unintended sound event.' ;...
        'Examples:' 
        '- An interfering radio signal.'
        '- A wrongly unmuted mixing desk channel.'};...
    40 {'Spatially separated, nearly simultaneous and not necessarily identical image of a sound source.' 
        'A kind of a spatial copy of a signal: A sound source appears at one or more additional positions in the scene.'; ...
       'Examples:'; ...
       '- Two sound sources which are erroneously playing back the same audio content.'; ...
       '- Double images when down-mixing main and spot microphone recordings.'; ...
       '- Spatial aliasing in wave field synthesis (WFS): Sound sources are perceived as ambivalent in direction.'};...
    41 {'Percept as a result of non-linear distortions as caused e.g. by clipping. Scratchy or "broken" sound. Often dependent on signal amplitude. Perceptual quality can vary widely depending on the type of distortion.'; ...
       'Example: Clipping of digital input stages.'};...
    42 {'Perception at the border between auditory and tactile modality. Vibration caused by a sound source can be felt through mechanical coupling to supporting surfaces.';...
       'Examples:'; ...
       '- live concert: Bass can be "felt in the stomach".';...
       '- Headphone cushions vibrate noticeably on the ear/head.'};...
    43 'Clarity/clearness with respect to any characteristic of elements of a sound scene. Impression of how clearly different elements in a scene can be distinguished from each other or how well various properties of individual scene elements can be detected. The term is thus to be understood much broader than the in realm of room acoustics, where clarity is used to predict the impression of declining transparency with increasing reverberation.';...
    44 {'Impression of how well the words of a speaker can be understood.'; ...
       '- Typical for low speech intelligibility: train station announcements'; ...
       '- Typical for high speech intelligibility: newscaster'};...
    45 'Impression that a signal is in accordance with the expectation/former experience of an equivalent signal.';...
    46 'Perception of "being-in-the-scene", or "spatial presence". Impression of being inside a presented scene or to be spatially integrated into the scene.';...
    47 'Difference with respect to pleasantness/unpleasantness. Evaluation of the perceived overall difference with respect to the degree of enjoyment or displeasure. Note that "preference" might not be used synonymously, as, e.g., there may be situations where something is preferred that is - at the same time - not liked most.';...
    48 'Another, previously unrecognized difference.';...
     };
