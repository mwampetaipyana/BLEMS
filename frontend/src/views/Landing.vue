<template>
    <div class="h-screen flex space-y-3 flex-col px-8 py-2 transition-all duration-300 ease-in" >
        <div class="flex flex-col min-h-[500px] md:h-[45vh] py-4 ">
                <nav class=" w-full md:h-16 max-md:h-10 flex items-center  justify-between py-2">
                    <div class="flex flex-row space-x-3">
                        <img class="w-16 h-16" src="../assets/images/Coat_of_arms_of_Tanzania.svg" alt="">

                        <div class="font-mono text-main leading-1 tracking-wider font-[560] text-4xl my-auto">
                            BLEMS
                        </div>
                    </div>
                    

                    <!-- class="bg-main font-sans py-2 px-3 text-white text-md rounded-[3px] hover:shadow-lg" -->
                   
                    <v-btn @click="connect()" :loading="isLoading"  color="main"><div class="text-white">Connect</div></v-btn>
                </nav>

                <div class="w-full h-[80%] rounded-[10px] bg-main2 md:min-w-[1200px] flex flex-row items-center px-8 font-sans max-md:py-8 mt-8 ">
                    <div class="md:w-1/2 w-full flex flex-col justify-center h-full">
                        <div class="lg:text-[28px] xl:text-[45px] text-2xl gap-3 leading-tight flex  justify-left font-[500] tracking-tighter ">
                            Securely manage evidence <br> with blockchain<br>
                            Building&nbsp;trust&nbsp;in&nbsp;justice.
                        </div>
                       
                    </div>
                    
                    <div class="w-1/2 h-full max-md:hidden overflow-hidden flex items-center">
                        <img  class="h-[480px] mx-auto" src="/src/assets/images/lawfirm.gif" alt="law firm">
                    </div>
                </div>
        </div>

        <div class="mt-4 flex flex-col md:h-[40vh] md:min-w-[1200px] overflow-hidden">
            <div class="md:text-[45px] text-3xl justify-between mb-4 font-bold gap-3 tracking-tighter"> Why we work?</div>
            <div class="flex flex-row justify-between flex-wrap max-md:flex-col max-md:space-y-2">
                <div class="flex min-h-32 h-1/2 flex-row w-[30%] max-md:w-full min-w-[300px] border-[1px] shadow shadow-main2 rounded-lg border-main2">
                    <div class="w-3/5  font-sans p-4 space-y-3">
                        <div class="text-md font-bold w-full">
                            Administering&nbsp;of&nbsp;Justice
                        </div>
                        <div class="text-gray-500 text-sm">
                            With the BLEMS's transparency,<br> evidences and reports are efficiently transparent <br>
                            to all parties involved in a case.
                        </div> 
                    </div>
                    <div class="w-2/5 h-full bg-main2 flex items-center justify-center">
                        <img class="h-3/4" src="/src/assets/images/hammer.png" alt="">
                    </div>
                </div>

                <div class="flex flex-row w-[30%] min-h-32 h-1/2  max-md:w-full min-w-[300px] border-[1px] shadow shadow-main2 rounded-lg border-main2">
                    <div class="w-3/5 h-full font-sans p-4 space-y-3">
                        <div class="text-md font-bold w-full">
                            Bringing&nbsp;fair&nbsp;decisions
                        </div>
                        <div class="text-gray-500 text-sm">
                            The high traceability and auditability of the system,
                            ensures that appropriate and fair decisions are made.
                        </div>
                    </div>
                    <div class="w-2/5 h-full bg-main2">
                        <img class="h-full" src="/src/assets/images/scale.png" alt="">
                    </div>
                </div>

                <div class="flex flex-row w-[30%] min-h-32 h-1/2 max-md:w-full min-w-[300px] border-[1px] shadow shadow-main2 rounded-lg border-main2">
                    <div class="w-3/5 h-full font-sans p-4 space-y-3">
                        <div class="text-md font-bold w-full">
                            Corruption&nbsp;mitigation
                        </div>
                        <div class="text-gray-500 text-sm">
                            BLEMS is built on a blockchain infrastructure <br>that ensures the security of data, 
                             making evidences tamper-proof.
                        </div>
                    </div>
                    <div class="w-2/5 h-full bg-main2 flex items-center justify-center">
                        <img class="h-full" src="/src/assets/images/bribery-removebg.png" alt="">
                    </div>
                </div>
            </div>
        </div>

        
        <footer class="w-full ">

        </footer>
    </div>
</template>

<script setup>
 import { ref } from 'vue'; 
 import {useRoute, useRouter} from 'vue-router'
 import { login } from '@/utils/contractService';
 const router = useRouter();

 const isLoading = ref(false);

 const connect = async()=>{
    isLoading.value = true;
    await login();
    isLoading.value = false;
 }
</script>