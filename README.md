# BER for BPSK in AWGN and Rayleigh fading MIMO channels
# Detection Algorithms: 
  - Maximum Likelihood (ML)
  - Zero-forcing (ZF)
  - Linear Minimum Mean Squared Error (L-MMSE)

---

#### Case 1: AWGN channel + Hard-decision decoding
<img src="https://github.com/TiepMH/Modulation_Schemes/blob/main/BPSK__AWGN_channel/BER%20for%20BPSK%20in%20AWGN%20SISO%20systems.png" width="50%" height="50%">

---

#### Case 2: Rayleigh fading SISO channel & ML decoding
<img src="https://github.com/TiepMH/Modulation_Schemes/blob/main/BPSK__Rayleigh_SISO__ML_decoding/BER%20for%20BPSK%20in%20Rayleigh%20fading%20SISO%20systems%20using%20ML%20decoding.png" width="50%" height="50%">

As for the theoretical curve, please refer to [R1, page 7] for a derivation.

[R1] https://www.unilim.fr/pages_perso/vahid/notes/ber_awgn.pdf

---

#### Case 3: Rayleigh fading SISO channel & ZF decoding
<img src="https://github.com/TiepMH/Modulation_Schemes/blob/main/BPSK__Rayleigh_SISO__ZF_decoding/BER%20for%20BPSK%20in%20Rayleigh%20fading%20SISO%20systems%20using%20ZF%20decoding.png" width="50%" height="50%">

---

#### Case 4: Rayleigh fading SISO channel & L-MMSE decoding
<img src="https://github.com/TiepMH/Modulation_Schemes/blob/main/BPSK__Rayleigh_SISO__MMSE_decoding/BER%20for%20BPSK%20in%20Rayleigh%20fading%20SISO%20systems%20using%20MMSE%20decoding.png" width="50%" height="50%">

---

Observation: The BER performance in the case of ML decoding is almost the same as the ZF decoding and the MMSE decoding. However, the complexity of the ML decoding is *higher* than the ZF and MMSE decoding. In fact, The BER performance will be different if we choose another modulation scheme and change the number of transmit/receive antennas. In general, both the ZF-based BER performance and MMSE-based BER performance will be worse than the BER performance of the ML decoding.

---

#### Case 5: Rayleigh fading 2X2 MIMO channel & ZF or MMSE decoding
<img src="https://github.com/TiepMH/Modulation_Schemes/blob/main/BPSK_Rayleigh_MIMO__ZF_or_MMSE/BER_in_Rayleigh_fading_MIMO_using_ZF_or_MMSE.png" width="50%" height="50%">

---

#### Case 6: Rayleigh fading 2X2 MIMO channel & ZF SIC
<img src="https://github.com/TiepMH/Modulation_Schemes/blob/main/BPSK_Rayleigh_MIMO__ZF_SIC/BER_in_Rayleigh_fading_MIMO_using_ZF_SIC.png" width="50%" height="50%">


