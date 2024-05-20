import { ethers } from "ethers";
import {abi} from "../contract/Legal.json"
import router from "@/router";
import { notifyError, notifySuccess } from "./notificationService";

//CONTRACT AND WALLET RELATED
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"

export const getProvider = () => {
    return new ethers.providers.Web3Provider(window.ethereum) ;
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
    console.log(signerAddress);
    const userType = await contract.Login(signerAddress)
       
       if(userType === null)
        return 

       if(userType === "admin"){
        setState('signer',signerAddress);
        router.push("/adm")
       }

       else if(userType === "user"){
        setState('signer',signerAddress);
        LoggedIn.value = getState()
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

