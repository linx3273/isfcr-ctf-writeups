# Secrets of Alice and Bob

**Category**: Cryptography

Can you find what the shared secret between Alice and Bob is?\
flag format: isfcr{shared_secret}

# Solution
# Some notations and formulae
- Base: `g`
- Shared modulus: `p`
- Alice secret key: `a`
- Bob secret key: `b`
- Alice public key: `A`
- Bob public key: `B`

- Secret key = `A^b mod p` = `B^a mod p`

# Approach to solving
Analyze `diffie-hellman.pcapng` using wireshark. Select on the first packet > Follow TCP Stream. All required values for diffie-hellman key generation are given over there.\
The secret key generated is the considered as the shared secret and that is our flag.

# Flag
`isfcr{0xb33ac0fbec48b8cbca7cb82ff8800339f4023b88a710c3fc8bbaa420f5a1e1a5de159177fb49c331600dfb33dbeec09db85d229865f702d320237ba9484b9d4e3c8b374410282b2fe19c2a39ad21ed69424954d571667abd961b81a2a2733c2be8c635aafcc53b8a923d1d44c346585aa089816230504abecb94bcab367abf42}`
# References
[Wikipedia](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)
[cryptobook.nakov.come](https://cryptobook.nakov.com/key-exchange/diffie-hellman-key-exchange)