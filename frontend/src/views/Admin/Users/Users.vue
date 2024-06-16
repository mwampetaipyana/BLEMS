<template>
    <div class="w-full flex flex-col">
            
            <div class="flex flex-row xl:w-[80%] md:w-full justify-between mb-3 ">
                <div class="w-1/4">
                    <v-select
                    v-model="filter"
                    density="compact"
                    width="20"
                    label="Filter"
                    :items="['All', 'judge', 'police', 'lawyer', 'forensic','prosecutor']"
                    variant="outlined"
                    ></v-select>
                </div>
                
                <div class="w-1/4">
                    <v-text-field
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
            <div v-motion-fade v-if="!isLoading" class="xl:w-[80%] md:w-full mr-auto">
                <v-table
                height="100%"
                width="75%"
                fixed-header
                >
                    <thead>
                        <tr>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Name</span>
                            </th>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Address</span>
                            </th>
                            <th  style="background-color: #ebebeb;" class="text-left w-full flex flex-row items-center justify-between space-x-4">
                                <span class="text-md text-gray-600 font-bold">Position</span>
                                <v-btn v-if="role=='admin'" @click="newUserOverlay = !newUserOverlay"  color="main"><div class="text-white">Add user</div></v-btn>
                            </th>
                            <th v-if="role=='prosecutor'"  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Number&nbsp;of&nbsp;Cases</span>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(user,index) in displayedUsers" :key="user.address" class="h-fit">
                            <td class="flex flex-row items-center h-full"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        person
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">{{ user.name }}</div>
                                    <div class="flex flex-col space-x-2 font-sans font-medium text-gray-600">
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">{{user.userAddress}}</div>
                                    </div>
                                </div>
                            </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                        <div class="font-bold text-gray-800">
                                            <span class="text-gray-600">&nbsp;{{ capitalize(user.position) }}</span> 
                                        </div>
                                </div>
                            </td>
                            <td v-if="role=='prosecutor'" class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                        <div class="font-bold text-gray-800">
                                            <span class="text-gray-600">&nbsp;{{ noOfCases[index] }}</span> 
                                        </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </v-table>
                <div class="text-center">
                            <v-overlay v-model="newUserOverlay">
                                <div @click="newUserOverlay = !newUserOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                                    <NewUserView @close="closeModal()"/>
                                </div>
                            </v-overlay>
                        </div>
            </div>
            <div v-if="isLoading" class="xl:w-[80%] md:w-full mr-auto">
                    <loader/>
            </div>
        </div>    
</template>


<script setup>
 import {ref, onMounted, watch} from "vue"
 import NewUserView from "./NewUser.vue"
 import { getSignerContract, getState } from "@/utils/contractService";
 import Loader from "@/components/Loader.vue";

 const isLoading = ref(true)

 const getUsers =async ()=>{
    const {contract} = await getSignerContract();
    users.value = await contract.getUsers();
    displayedUsers.value = users.value;
    isLoading.value = false
}

const role = ref('')
const users = ref([])
const displayedUsers = ref([])
const noOfCases = ref([])

 onMounted(async()=>{
    role.value = getState('role')
    await getUsers();
    await getNumberOfCases(users.value);
 })

 const filter = ref('All');
 const newUserOverlay = ref(false);
 const search = ref('')

 //filters
 watch(async()=> [search.value,filter.value], async()=>{
        displayedUsers.value = users.value.filter(user =>{
            if(search.value && filter.value!='All'){
                return  user.name.toLowerCase().includes(search.value.toLowerCase()) && user.position.includes(filter.value)
            }
            else if(filter.value!='All'){
                return user.position.includes(filter.value)
            }
            else if(search.value){
                return  user.name.toLowerCase().includes(search.value.toLowerCase())
            }

            else return true;
        });
        await getNumberOfCases(displayedUsers.value);
})

const closeModal = ()=>{
    newUserOverlay.value = !newUserOverlay.value
    setTimeout(() => {
      getUsers();
    }, 20000);
}

const capitalize = (text)=> {
  if (!text) return ""; // Handle empty string case
  return text.charAt(0).toUpperCase() + text.slice(1);
}

const getNumberOfCases = async(users)=>{
    users.forEach(async(user,index)=>{
        const {contract} = await getSignerContract();
        const mycases = await contract.getmyCase(user.userAddress);
        noOfCases.value[index] = mycases.length;
    })
}

</script>