const crypto = require("crypto");

// 生成 RSA 公私钥对
function generateKeyPair() {
  const { publicKey, privateKey } = crypto.generateKeyPairSync("rsa", {
    modulusLength: 2048, // 密钥长度
    publicKeyEncoding: { type: "spki", format: "pem" },
    privateKeyEncoding: { type: "pkcs8", format: "pem" }
  });
  return { publicKey, privateKey };
}

// POW 计算，找到满足4个0开头的哈希
function proofOfWork(nickname, targetZeros) {
  let nonce = 0;
  const target = "0".repeat(targetZeros); // 目标前导0
  const startTime = Date.now();
  
  while (true) {
    const data = nickname + nonce;
    const hash = crypto.createHash("sha256").update(data).digest("hex");

    // 检查哈希值是否满足前导零要求
    if (hash.startsWith(target)) {
      const endTime = Date.now();
      const timeSpent = (endTime - startTime) / 1000;
      console.warn(`前${targetZeros}位0花费时长: `, timeSpent);
      return { data, hash, nonce };
    }
    nonce++;
  }
}

// 使用私钥签名数据
function signData(privateKey, data) {
  const sign = crypto.createSign("SHA256");
  sign.update(data);
  sign.end();
  return sign.sign(privateKey, "hex"); // 返回签名
}

// 使用公钥验证签名
function verifySignature(publicKey, data, signature) {
  const verify = crypto.createVerify("SHA256");
  verify.update(data);
  verify.end();
  return verify.verify(publicKey, signature, "hex");
}

// 主流程
function main(nickname, targetZeros) {
  // 1. 生成 RSA 公私钥对
  const { publicKey, privateKey } = generateKeyPair();
  console.log("公钥:", publicKey);
  console.log("私钥:", privateKey);

  // 2. POW 找到满足条件的哈希值
  const { data, hash, nonce } = proofOfWork(nickname, targetZeros);
  console.log("Data:", data);
  console.log("Hash:", hash);
  console.log("Nonce:", nonce);

  // 3. 使用私钥对数据进行签名
  const signature = signData(privateKey, data);
  console.log("签名:", signature);

  // 4. 使用公钥验证签名
  const isValid = verifySignature(publicKey, data, signature);
  console.log("签名验证:", isValid);
}

main('zaven', 4);
