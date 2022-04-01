# babyrsa

**Category**: Cryptography

you only need a little bit of meth for this...\
flag format: isfcr{xxx}

- chall.py
```python
from Crypto.Util.number import (
  getPrime,
  bytes_to_long,
  GCD
)

def get_good_prime (e, nbits):
  while True:
    p = getPrime(nbits)
    if GCD(p - 1, e) == 1:
      return p

flag = b'isfcr{fake_flag_of_same_length_xxxxxxxx}'g

assert(len(flag) == 40)

flag1 = flag[00:20]
flag2 = flag[20:40]

e = 65537
nbits = 512

p1 = get_good_prime(e, nbits)
q1 = get_good_prime(e, nbits)
p2 = get_good_prime(e, nbits)
q2 = get_good_prime(e, nbits)

n1 = p1 * q1
n2 = p2 * q2
c1 = pow(bytes_to_long(flag1), e, n1)
c2 = pow(bytes_to_long(flag2), e, n2)

with open('cipher.txt', 'w') as file:
  print("e =", e, file = file)
  print("n1 =", n1, file = file)
  print("n2 =", n2, file = file)
  print("c1 =", c1, file = file)
  print("c2 =", c2, file = file)
  print("p1 + q1 =", p1 + q1, file = file)
  print("p2 - q2 =", p2 - q2, file = file)

```

- cipher.txt
```txt
e = 65537
n1 = 90211673242790001500628342565903247007775017202313471657884754833581831727052006371923820773182342186245454390494643122172118622457924187965544981135332862434521152337180276324815583587147664041399627462347835722156736603777790033044889104169160096864246910915990887174022540781662706403342549579465965779629
n2 = 107401836996357776843167507123496116703248388680312453575535753403171213299589226334291290169951671567629896862287670479624579772906180575510351091259867185261898218197485402386026108133503792883564951165101657481065202270562491150060583460139551703664500535175811886929397358487156321764850107491062977473251
c1 = 57939460010965161947655351533945278688914583112010874746475328125390445746997371522065245491866781515338584040629643455973329874209358340466123699842553046042731830350741191797769661069278049811138192382021621224261216699913925222098351847594618724396888752665375235558659776341850911467824480066455121723307
c2 = 7525557453562203045683327451889181091690372894567608502186004231336113836649146380605171782551926500302563755942974861220928468061323645164922483089596823363163416914827310326078517660225838158143779310241581112632659956188024803020150649974351513086625783152653099491321474770428739967652480414771442832300
p1 + q1 = 19437960902404435833570957749724172241765086298986094517255034438475356225673865606728403796273621515952385771151641874526786850075037988727019752971227054
p2 - q2 = 1611354608487311179609700118241236904590063813231567620068697042085949202301014684571669291525358537186452920951461765780452790857499940909710541089578686
```
# Solution
# Formulae required
**For Encryption**\
`c = m^e mod n`

**For decryption**\
`m = c^d mod n`\
`d = e^(-1) mod (p-1)(q-1)`

c - cipher text\
m - messsage\
n = p*q\
where p and q are two large prime numbers

# Approach to solving
We know that this challenge was called 'babyrsa' and after a bit of googling one can realize that RSA is a cryptography method. Now looking at `chall.py` and `cipher.txt` it can be concluded that two decryptions are required. One using `n1,c1,p1+q1` and another using `n2,c2,p2-q2`.

In both cases, d1,d2 is required for decrypting the ciphertext. `d1` can be obtained using the relation `d = e^(-1) mod (p-1)(q-1)`.

- Obtaining (p1-1)(q1-1)
```
(p-1)(q-1) 
= pq - p - q + 1
= pq - (p + q) + 1
= n - (p + q) + 1          # we know n = p*q
```
Therfore we can now compute `d1` with the above relation and decrypt and obtain message `m1`.

For the second part the relation provided is `p2-q2` and writing obtaining a relation like done above is not possible in this case. Quadratic equations will have to be used in this case
```
n = pq

p-q = c     # where c is some constant
so, p = c+q

therefore 
n = (q+c)q
n = q^2 + qc 
q^2 + qc - n =0

find q using the quadratic discriminant formula and get p
```
using `q2` and `p2` , `d2` can be found and using this we can decipher `c2` to obtain the message `m2`.

# Flag
`isfcr{qu4dr4t1c_3quation5_f0r_th333_w1n}`

# References
[Youtube](https://www.youtube.com/watch?v=vf1z7GlG6Qo)\
[cryptobook.nakov.com](https://cryptobook.nakov.com/asymmetric-key-ciphers/the-rsa-cryptosystem-concepts)\
[Wikipedia](https://en.wikipedia.org/wiki/RSA_(cryptosystem))


