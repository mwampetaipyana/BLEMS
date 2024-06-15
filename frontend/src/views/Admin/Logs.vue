<template>
    <div v-if="!isLoading" v-motion-fade class="w-full h-[90%] flex-col overflow-y-auto ">
        <div class="w-full mb-8">
            <div class="w-1/4">
                    <v-text-field
                        :disabled="! transactions.length > 0"
                        density="compact"
                        class="h-1/2 text-caption font-weight-bold font-sans"
                        width="50%"
                        v-model="search"
                        label="Search by Case number"
                        prepend-inner-icon="mdi-magnify"
                        variant="solo-filled"
                        flat
                        hide-details
                        single-line
                    ></v-text-field>
                </div>
        </div>

        <div v-for="transaction in displayedTransactions" :key="transaction" class=" mb-1 mr-8 border border-1 py-2 md:px-8 max-md:px-5 rounded-lg border-main ">
            <div class="flex flex-col">
                <div class="text-main text-md font-semibold">Case {{transaction.caseNumber}}&nbsp;&nbsp;Action : {{transaction.transactionType}}</div>
                <div class="text-md text-gray-700 font-semibold">Triggered by {{transaction.userAddress}}</div>
                <div class="text-md text-gray-600">On {{ getDate(transaction.timestamp) }}</div> 
            </div>
        </div>
    </div>
    <div v-if="isLoading" v-motion-fade class="w-3/4 h-full mx-auto py-8  p-4 flex flex-col">
         <loader/>
    </div>
</template>

<script setup>
import {ref, onMounted, watch} from "vue"
import { getState, getSignerContract, getDate } from "@/utils/contractService";
import loader from "@/components/Loader.vue"

const isLoading = ref(true)
const transactions = ref([])
const displayedTransactions = ref([])
const search = ref(null)
const isExpanded = ref(false);
const expandedCase = ref('');
const actors = ref([])

watch(search, ()=>{
    displayedTransactions.value = transactions.value.filter(transaction =>{
        if(search.value.trim){
            return  transaction.caseNumber.toLowerCase().includes(search.value.toLowerCase())
        }
        else return true;
    });
})

const getTransactions = async()=>{
    const {contract}  =await getSignerContract(); 
    transactions.value = await contract.getSystemTxns()
    displayedTransactions.value = transactions.value
}


onMounted(async ()=>{
    await getTransactions();
    isLoading.value = false
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