<template>
    <div class="w-full h-full flex-col overflow-y-auto ">
        <div class="w-full mb-8">
            <div class="w-1/4">
                    <v-text-field
                        :disabled="! cases.length > 0"
                        density="compact"
                        class="h-1/2 text-caption font-weight-bold font-sans"
                        width="50%"
                        v-model="search"
                        label="Search"
                        prepend-inner-icon="mdi-magnify"
                        variant="solo-filled"
                        flat
                        hide-details
                        single-line
                    ></v-text-field>
                </div>
        </div>
        <div v-for="(oneCase,index) in displayedCases" :key="oneCase.case_no" class="overflow-hidden transition duration-800 ease-in-out" :class="{'h-12':!(isExpanded && expandedCase == oneCase.case_no)}">
            <div class="flex flex-row justify-between md:px-8 max-md:px-5  mb-2 mr-8 border-2 py-2 border-main">
                <div class="text-xl text-gray-700 font-semibold tracking-tighter font-sans">
                    Case&nbsp;{{ oneCase.case_no }}
                </div>
                <v-btn @click="toggleCase(oneCase.case_no,index)" color="main" density="comfortable" variant="text" :icon="(isExpanded && expandedCase == oneCase.case_no)?'mdi-arrow-up-drop-circle':'mdi-arrow-down-drop-circle'" size="medium"></v-btn>
            </div>
            
            <div v-if="isExpanded" class="flex flex-col w-full">
                <div v-for="(transaction,index2) in transactions[index]" :key="transaction" class=" mb-1 mr-8 border border-1 py-2 md:px-8 max-md:px-5 rounded-lg border-main">
                    <div class="flex flex-col">
                        <div class="text-main text-md font-semibold"> Action : {{transaction.transactionType}}</div>
                        <div class="text-md text-gray-700 font-semibold">Triggered by {{transaction.userAddress}}, {{capitalize(actors[index2][1])}}, {{actors[index2][0]}}</div>
                        <div class="text-md text-gray-600">On {{ getDate(transaction.timestamp) }}</div> 
                    </div>
                </div>
            </div>
        </div>
       
        
    </div>
</template>

<script setup>
import {ref, onMounted, watch} from "vue"
import { getState, getSignerContract, getDate } from "@/utils/contractService";

const transactions = ref([])
const cases = ref([])
const displayedCases = ref([])
const search = ref(null)
const isExpanded = ref(false);
const expandedCase = ref('');
const actors = ref([])

watch(search, ()=>{
    displayedCases.value = cases.value.filter(oneCase =>{
        console.log(search.value);
        if(search.value.trim){
            console.log('passed');
            return  oneCase.case_no.toLowerCase().includes(search.value.toLowerCase())
        }
        else return oneCase;
    });
})

const getTransactions = async(caseNumber)=>{
    const {contract}  =await getSignerContract(); 
    return await contract.getCaseTxns(caseNumber)
}

const getMyCases = async ()=>{
    const {signer,contract} = await getSignerContract()
    cases.value = await contract.getmyCase(signer.getAddress());
    displayedCases.value = cases.value

    cases.value.forEach(async(oneCase,index)=>{
        const CaseTransactions = await getTransactions(oneCase.case_no)
        transactions.value.push(CaseTransactions)
    })
    console.log(transactions.value);
}

onMounted(()=>{
    getMyCases();
})

const toggleCase = (caseNumber,index)=>{
    if( expandedCase.value == caseNumber){
        isExpanded.value = false
        expandedCase.value = ''
    }
    else{
        isExpanded.value = true
        expandedCase.value = caseNumber
        getUserDetails(index)
    }
}
const getUserDetails = async (index)=>{
    const {contract} = await getSignerContract()
    transactions.value[index].forEach(async (transaction,index) => actors.value[index] =  await contract.login(transaction.userAddress))
}
const capitalize = (text)=> {
  if (!text) return ""; // Handle empty string case
  return text.charAt(0).toUpperCase() + text.slice(1);
}
</script>