rem ping three target
for /F "tokens=1-3" %i IN ("ntu nccu nctu") do (
    start ping www.%i.edu.tw
    start ping www.%j.edu.tw
    start ping www.%k.edu.tw
)