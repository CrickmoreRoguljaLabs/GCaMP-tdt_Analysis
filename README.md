# GCaMP-tdt_Analysis
Code for analyzing baseline activity by normalizing GCaMP fluorescence to tdtomato signal.

## Preparing your images
Samples were nervous systems expressing GAL4>opGCaMP6s,tdttomato. All samples were dissected quickly in Drosophila saline, then mounted in a petri dish with ~ 4 ml of the same saline. Images were acquired on a Zeiss LSM 710 micrscope in the Cellular Imaging Core at BCH using a Mai Tai 2-photon laser and a W Plan-Apochromat 20x/1.0 DIC VIS (IR) M27 75 mm objective. The laser was set to 960 nm such that both GCaMP and tdtomato would be excited by the laser and their fluorescence could be captured in a single image. 
Within the Zen black software the following settings were used: 
512 x 512 pixels 
speed = 7
avg = 1
8 bit
zoom = 1.0* but this can be easily changed depending on your sample
slices were 3 um thick and enough slices were taken to cover the entire region of interest, as seen via the tdtomato channel
laser = 960 nm
laser power = 12.0
gain (for both green and red channels) = 750

## Converting LSM files to Tiffs with the GCaMP/tdt macro
