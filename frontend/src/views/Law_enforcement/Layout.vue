<template>
    <div class="w-full h-screen flex flex-col">

        <div class="flex flex-row h-full">

            <div class="absolute h-auto w-full flex justify-between p-2 max-md:opacity-0 z-20 transition-opacity duration-400 ease-in items-center bg-white border-b-[1px] shadow-sm">
                <div @click="router.push({name:'landing'})" class="font-mono text-main leading-1 tracking-wider font-[560] text-4xl">
                    BLEMS
                </div>

                <div  class="relative flex flex-row space-x-4 px-3 font-medium text-lg transition-all duration-300 ease-out">
                    <button @click="showLogoutModal=!showLogoutModal" class="flex flex-row items-center">
                         <div class="p-1 border-2 rounded-full border-main">
                            <svg width="25px" height="25px" class="text-white" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z" stroke="#30564b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M12 14C8.13401 14 5 17.134 5 21H19C19 17.134 15.866 14 12 14Z" stroke="#30564b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                         </div>
                         <svg class="transition duration-200 ease-in-out" :class="{'translate-y-2':showLogoutModal}" width="30px" height="30px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M12.7071 14.7071C12.3166 15.0976 11.6834 15.0976 11.2929 14.7071L6.29289 9.70711C5.90237 9.31658 5.90237 8.68342 6.29289 8.29289C6.68342 7.90237 7.31658 7.90237 7.70711 8.29289L12 12.5858L16.2929 8.29289C16.6834 7.90237 17.3166 7.90237 17.7071 8.29289C18.0976 8.68342 18.0976 9.31658 17.7071 9.70711L12.7071 14.7071Z" fill="#30564b"/>
                        </svg>
                    </button>

                    <div  
                    class=" absolute -bottom-28 rounded -left-24 w-[150px] bg-main font-sans text-white flex flex-col h-24 p-2 transition-all duration-400 ease-in" :class="{' opacity-0 -translate-y-4 cursor-not-allowed hidden':!showLogoutModal,' opacity-1 translate-y-0': showLogoutModal}">
                        <div class="border-b-[1px] border-gray-50 text-sm text-left p-2">Pablo Escobar</div>
                        <button @click="logout()" class="flex flex-row items-center space-x-2 p-1 my-1 hover:bg-gray-100 hover:bg-opacity-10  hover:rounded-lg">
                            <span class="material-symbols-outlined">
                                logout
                            </span>
                            <p class="text-[14px] text-left">Logout</p> 
                        </button>
                    </div>
                </div>
            </div> 

            <!-- sidebar -->
            <div @click="showLogoutModal = false" class="font-sans relative max-md:absolute max-md:bg-white max-md:z-30 max-md:border-r-[2px] left-0 z-16 h-full flex flex-col space-y-2 overflow-hidden transition-width duration-300 ease-in pt-[110px]" :class="{'md:w-20 max-md:w-0':!sidebarExpanded,'md:w-64 max-md:w-3/4':sidebarExpanded }">
                <div class="absolute md:hidden top-0 flex flex-row justify-between px-4 w-full"> 
                    <button type="button" class=" p-1 h-fit right-0 top-2 ml-auto transition duration-300 ease-in z-16 m-2" :class="{'  bg-white flex items-center justify-center flex-col':!sidebarExpanded}" @click="sidebarExpanded =!sidebarExpanded">
                          <div class="w-[23px] h-[2px] transition ease-in duration-150 bg-main mb-1" :class="{'rotate-45 mb-0 translate-y-[1px]':sidebarExpanded,'rotate-0 mb-1':!sidebarExpanded}"></div>
                          <div class="w-[23px] h-[2px] transition ease-in duration-150 bg-main mb-1" :class="{'hidden mb-0':sidebarExpanded,'mb-1':!sidebarExpanded}"></div>
                          <div class="w-[23px] h-[2px] transition ease-in duration-150 bg-main mb-1" :class="{'-rotate-45 mb-0 translate-y-[-1px]':sidebarExpanded,'rotate-0 mb-1':!sidebarExpanded}"></div>
                   </button>
                </div>

                <router-link 
                :to="{ name: 'Dashboard' }"
                v-motion
                :initial="{ x: 60 }"
                :enter="{ x: 0, transition: { duration: 1000 } }"
                :class="{'bg-[#51751d] bg-opacity-10 text-gray-900':useRoute().name==='Dashboard'}" 
                class="py-1 flex flex-row  px-2 space-x-4  border-[1px] border-transparent hover:border-[#51751d] text-gray-600 border-b-gray-200  mx-3 rounded-md transition-opacity transition-border duration-300 ease-in">
                <span class="material-symbols-outlined">
                     dashboard
                </span>
                    <div :class="{'opacity-0':!sidebarExpanded}" class="text-md font-semibold mt-auto" >Dashboard</div>

                </router-link>

                <router-link 
                :to="{ name: 'Evidence' }"
                v-motion
                :initial="{ x: 60 }"
                :enter="{ x: 0, transition: { duration: 1000 } }"
                :class="{ 'bg-[#51751d] bg-opacity-10 text-gray-900':useRoute().name==='Evidence'}" 
                class="py-1 flex flex-row px-2 space-x-4 border-[1px] border-transparent hover:border-[#51751d] text-gray-600  border-b-gray-200  mx-3 rounded-md transition-opacity duration-300 ease-in">
               
                    <span class="material-symbols-outlined">
                        description
                    </span>
                    <span :class="{'opacity-0':!sidebarExpanded}" class="text-md font-semibold mt-auto" >Evidence</span>

                </router-link>

                <router-link 
                :to="{ name: 'Cases' }"
                v-motion
                :initial="{ x: 60 }"
                :enter="{ x: 0, transition: { duration: 1000 } }"
                :class="{ 'bg-[#51751d] bg-opacity-10 text-gray-900':useRoute().name==='Cases'}" 
                class="py-1 flex flex-row px-2 space-x-4 border-[1px] border-transparent hover:border-[#51751d] text-gray-600  border-b-gray-200  mx-3 rounded-md transition-opacity duration-300 ease-in">
               
                <span class="material-symbols-outlined">
                    <span class="material-symbols-outlined">
                        inventory_2
                    </span>
                </span>
                <span :class="{'opacity-0':!sidebarExpanded}" class="text-md font-semibold mt-auto" >Cases</span>

                </router-link>

                <router-link 
                :to="{ name: 'Notifications' }"
                v-motion
                :initial="{ x: 60 }"
                :enter="{ x: 0, transition: { duration: 1000 } }"
                :class="{ 'bg-[#51751d] bg-opacity-10 text-gray-900':useRoute().name==='Notifications'}" 
                class="py-1 flex flex-row px-2 space-x-4 border-[1px] border-transparent hover:border-[#51751d] text-gray-600  border-b-gray-200  mx-3 rounded-md transition-opacity duration-300 ease-in">
               
                <span class="material-symbols-outlined">
                        notifications
                </span>
                <span :class="{'opacity-0':!sidebarExpanded}" class="text-md font-semibold mt-auto" >Notifications</span>

                </router-link>

            
            </div>


            <div @click="showLogoutModal = false"  class="flex w-full transition-width duration-200 ease-in flex-col mt-12 pt-3 rounded-md shadow border-[2px] border-gray-200 bg-white"  :class="{'max-md:-z-10':sidebarExpanded}">
               
                <nav class="h-16  w-full relative flex flex-row items-center">
                    <button type="button" class="absolute p-1 left-0 top-2 mr-auto transition duration-300 ease-in z-16 m-2" :class="{'  bg-white flex items-center justify-center flex-col':!sidebarExpanded}" @click="sidebarExpanded =!sidebarExpanded">
                        <div class="w-[23px] h-[2px] transition ease-in duration-150 bg-main mb-1" :class="{'rotate-45 mb-0 translate-y-[1px]':sidebarExpanded,'rotate-0 mb-1':!sidebarExpanded}"></div>
                        <div class="w-[23px] h-[2px] transition ease-in duration-150 bg-main mb-1" :class="{'hidden mb-0':sidebarExpanded,'mb-1':!sidebarExpanded}"></div>
                        <div class="w-[23px] h-[2px] transition ease-in duration-150 bg-main mb-1" :class="{'-rotate-45 mb-0 translate-y-[-1px]':sidebarExpanded,'rotate-0 mb-1':!sidebarExpanded}"></div>
                    </button>
                    <div class="ml-[50px] text-2xl text-gray-800 font-semibold tracking-tighter font-sans">
                        {{ useRoute().name }}
                        </div>
                </nav>

                <!-- main content -->
                <div class="mt-8 px-4 -z-5 relative m-5 h-[96%] my-1" :class="{'max-md:blur-sm max-md:pointer-events-none':sidebarExpanded}" >
                    <router-view></router-view> 
                </div>
            </div>
        </div>
    </div>
    
  </template>


<script setup>
    import {ref,onMounted, computed} from 'vue'
    import {useRoute, useRouter} from 'vue-router'
    import { logout,login } from '@/utils/contractService';
    import { getSignerContract } from '@/utils/contractService';

    const router = useRouter();
    const showLogoutModal = ref(false)
    const sidebarExpanded = ref(true)
    const profile = ref({})

    const handleAccountsChanged = async()=>{
        logout();
        await login();
    }

    window.ethereum.on("accountsChanged", handleAccountsChanged);

    const cases = ref([]);

    const getMyCases = async ()=>{
        const {signer,contract} = await getSignerContract()
        cases.value = await contract.getmyCase(signer.getAddress());
        console.log(cases.value);
    }


    onMounted(async () =>{
        await getMyCases();
     })

</script>

