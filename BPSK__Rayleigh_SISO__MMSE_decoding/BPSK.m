function s = BPSK(bit_seq)
    s = 2*bit_seq - 1;
    %for example, bit_seq = [1, 0, 0, 1], then s = [1, -1, -1, 1]
end

