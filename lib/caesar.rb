def caesar_cipher(string, shift)
  cipher = { a:  0, b:  1, c:  2, d:  3, e:  4, f:  5, g:  6,
             h:  7, i:  8, j:  9, k: 10, l: 11, m: 12, n: 13,
             o: 14, p: 15, q: 16, r: 17, s: 18, t: 19, u: 20,
             v: 21, w: 22, x: 23, y: 24, z: 25 }

  # The lookup table for the cipher table before shifting.
  alphabet = cipher.invert

  cipher.each { |k, v| cipher[k] = (v + shift) % 26 }

  encrypted = ""

  string.split("").each do |c|
    if c.match(/[[:alpha:]]/)
      if c == c.upcase 
        encrypted << alphabet[cipher[c.downcase.to_sym]].to_s.upcase
      else
        encrypted << alphabet[cipher[c.downcase.to_sym]].to_s
      end
    else
      encrypted << c
    end
  end
  return encrypted
end