import { useState, useEffect } from "react";
import { ethers } from "ethers";
import atm_abi from "../artifacts/contracts/Assessment.sol/Assessment.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [atm, setATM] = useState(undefined);
  const [balance, setBalance] = useState(undefined);
  const [amount, setAmount] = useState(0);
  const [interestAmount, setInterestAmount] = useState(0);
  const [penaltyAmount, setPenaltyAmount] = useState(0);

  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const atmABI = atm_abi.abi;

  const getWallet = async () => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const accounts = await ethWallet.request({ method: "eth_accounts" });
      handleAccount(accounts);
    }
  };

  const handleAccount = (accounts) => {
    if (accounts.length > 0) {
      setAccount(accounts[0]);
    }
  };

  const connectAccount = async () => {
    if (!ethWallet) {
      alert("MetaMask wallet is required to connect");
      return;
    }

    const accounts = await ethWallet.request({ method: "eth_requestAccounts" });
    handleAccount(accounts);

    // once wallet is set we can get a reference to our deployed contract
    getATMContract();

    getBalance();
  };

  const getATMContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const atmContract = new ethers.Contract(contractAddress, atmABI, signer);

    setATM(atmContract);
  };

  const getBalance = async () => {
    if (atm) {
      setBalance((await atm.getBalance()).toNumber());
    }
  };

  const deposit = async () => {
    if (atm) {
      let tx = await atm.deposit(amount);
      await tx.wait();
      getBalance();
    }
  };

  const withdraw = async () => {
    if (atm) {
      let tx = await atm.withdraw(amount);
      await tx.wait();
      getBalance();
    }
  };

  const payInterest = async () => {
    if (atm) {
      let tx = await atm.payInterest(interestAmount);
      await tx.wait();
      getBalance();
    }
  };

  const penalize = async () => {
    if (atm) {
      let tx = await atm.penalize(penaltyAmount);
      await tx.wait();
      getBalance();
    }
  };

  const initUser = () => {
    // Check to see if user has Metamask
    if (!ethWallet) {
      return <p>Please install Metamask in order to use this ATM.</p>;
    }

    if (balance === undefined) {
      getBalance();
    }
  };

  useEffect(() => {
    getWallet();
  }, []);

  return (
    <main className="container" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', minHeight: '100vh' }}>
      <header style={{ marginBottom: '1px', textAlign: 'center' }}>
        <h1 style={{ color: 'black' }}>Welcome to the Meta-Man Dex!</h1>
      </header>
      {account ? (
        <div style={{ textAlign: 'center' }}>
          <p style={{ color: 'black', marginBottom: '10px',fontSize: '20px', padding: '10px'}}>Your Account: {account}</p>
          <p style={{ color: 'black', marginBottom: '10px',fontSize: '20px',padding: '5px' }}>Your Balance: {balance}</p>
          <input
            type="number"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            placeholder="Enter amount"
            style={{ marginBottom: '10px', padding: '5px', width: '150px' }}
          />
          <button
            onClick={deposit}
            style={{ backgroundColor: 'white', color: 'black', marginRight: '10px', padding: '5px' }}
          >
            Deposit
          </button>
          <button
            onClick={withdraw}
            style={{ backgroundColor: 'white', color: 'black', padding: '5px' }}
          >
            Withdraw
          </button>
          <hr />
          <p style={{ color: 'black', marginBottom: '10px' }}>Pay Interest Amount:</p>
          <input
            type="number"
            value={interestAmount}
            onChange={(e) => setInterestAmount(e.target.value)}
            placeholder="Enter interest amount"
            style={{ marginBottom: '10px', padding: '5px', width: '150px' }}
          />
          <button
            onClick={payInterest}
            style={{ backgroundColor: 'white', color: 'black', marginRight: '10px', padding: '5px' }}
          >
            Pay Interest
          </button>
          <hr />
          <p style={{ color: 'black', marginBottom: '10px' }}>Penalize Amount:</p>
          <input
            type="number"
            value={penaltyAmount}
            onChange={(e) => setPenaltyAmount(e.target.value)}
            placeholder="Enter penalty amount"
            style={{ marginBottom: '10px', padding: '5px', width: '150px' }}
          />
          <button
            onClick={penalize}
            style={{ backgroundColor: 'white', color: 'black', padding: '5px' }}
          >
            Penalize
          </button>
        </div>
      ) : (
        <button
          onClick={connectAccount}
          style={{ backgroundColor: 'white', color: 'black', padding: '10px 20px', borderRadius: '5px' }}
        >
          Connect your Metamask wallet
        </button>
      )}
      {initUser()}
    </main>
  );
}
