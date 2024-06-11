import { ethers } from "ethers";
import {abi} from "../contract/Blems.json"
import router from "@/router";
import { notifyError, notifySuccess } from "./notificationService";

//CONTRACT AND WALLET RELATED
const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3"

export const getProvider = () => {
    return new ethers.providers.Web3Provider(window.ethereum);
}

export const getSignerContract = async () => {
    let provider = getProvider()
    await provider.send('eth_requestAccounts', [])
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);
    return { signer, contract }
}

export const getViewerContract = async () => {
    const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
    //let provider = getProvider()
    const contract = new ethers.Contract(contractAddress, abi, provider);
    return {  contract }
}


export const setObjectState = (state,value)=>{
    localStorage.setItem(state,JSON.stringify(value))
}

export const getObjectState = (state)=>{
    return JSON.parse(localStorage.getItem(state))
}

export const setState = (state,value)=>{
    localStorage.setItem(state,value)
}

export const getState = (state)=>{
    return localStorage.getItem(state)
}

export const resetState = (state)=> {
    localStorage.removeItem(state);
}


export const login = async ()=> {
    
    if(!window.ethereum.isMetaMask){
        notifyError('Install metamask!')
        return
    }
    const {contract} = await getViewerContract()
    const { signer } = await getSignerContract()
        
    const signerAddress = await signer.getAddress();
    const userType = await contract.login(signerAddress)
       console.log(userType);
       if(userType === null)
        return 

       if(userType[1] === "admin"){
        setState('signer',signerAddress);
        setState('role',"admin");
        router.push("/adm")
       }
       else if(userType[1] === "judge" || userType[1] === "forensic" || userType[1] === "prosecutor" || userType[1] === "police" || userType[1] === "user"){
        setState('signer',signerAddress);
        setState('role',userType[1]);
        router.push("/law_enforcement")
       }
       else {
        notifyError("Unauthorized User");
        return 
       }
      }
    export  const logout = ()=> {
        localStorage.clear()
        router.push('/')
         notifySuccess("Please disconnect from the wallet manually.");
    }

    export const getDate = (timestampInBigNumber)=>{
        const timestampInSeconds = ethers.BigNumber.from(timestampInBigNumber).toString();
        const timestampInMs = parseFloat(timestampInSeconds) * 1000;
        const date = new Date(timestampInMs);
        const month = date.toLocaleString('en-US', { month: 'short' }); // Get short month name
        const day = date.getDate().toString().padStart(2, '0'); // Pad day with leading zero
        const year = date.getFullYear();
        return `${month} ${day}, ${year}`;
    }