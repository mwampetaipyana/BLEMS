<template>
    <div class="h-screen flex space-y-3 flex-col px-8 py-2 transition-all duration-300 ease-in" >
        <div class="flex flex-col min-h-[500px] md:h-[45vh] py-4 ">
                <nav class=" w-full md:h-16 max-md:h-10 flex items-center  justify-between py-2">
                    <div class="font-mono text-main leading-1 tracking-wider font-[560] text-4xl">
                        BLEMS
                    </div>

                    <!-- class="bg-main font-sans py-2 px-3 text-white text-md rounded-[3px] hover:shadow-lg" -->
                   
                    <v-btn  color="main"><div class="text-white">Connect</div></v-btn>
                </nav>

                <div class="w-full h-[80%] rounded-[10px] bg-main2 md:min-w-[1200px] flex flex-row items-center px-8 font-sans max-md:py-8 mt-8 ">
                    <div class="md:w-1/2 w-full flex flex-col justify-center h-full">
                        <div class="lg:text-[28px] xl:text-[45px] text-2xl gap-3 leading-tight flex  justify-left font-[500] tracking-tighter ">
                            This is the app of your life mates,&nbsp;Welcome. <br>
                            Enjoy&nbsp;the&nbsp;many&nbsp;benefits of the&nbsp;Blockchain&nbsp;technology.
                        </div>
                        <div class="text-gray-500 text-lg mt-5">Paste the special evidence file hash that is made available for viewing:</div>

                        <div class="flex flex-row max-md:flex-wrap space-x-2 items-end">
                            <input class="h-16 bg-white mt-4 w-4/5 px-3 rounded-lg" type="text" placeholder="Evidence file Hash"/>
                          <v-btn height="64px" color="main"> <div class="font-sans text-white text-md text-lowercase"><span class="text-uppercase">V</span>iew</div></v-btn>  
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
                            Corrupt high&nbsp;ranking officials
                        </div>
                        <div class="text-gray-500 text-sm">
                            easily launder money mates
                        </div>
                    </div>
                    <div class="w-2/5 h-full bg-main2 flex items-center justify-center">
                        <img class="h-3/4" src="/src/assets/images/hammer.png" alt="">
                    </div>
                </div>

                <div class="flex flex-row w-[30%] min-h-32 h-1/2  max-md:w-full min-w-[300px] border-[1px] shadow shadow-main2 rounded-lg border-main2">
                    <div class="w-3/5 h-full font-sans p-4 space-y-3">
                        <div class="text-md font-bold w-full">
                            Corrupt high&nbsp;ranking officials
                        </div>
                        <div class="text-gray-500 text-sm">
                            easily launder money mates
                        </div>
                    </div>
                    <div class="w-2/5 h-full bg-main2">
                        <img class="h-full" src="/src/assets/images/scale.png" alt="">
                    </div>
                </div>

                <div class="flex flex-row w-[30%] min-h-32 h-1/2 max-md:w-full min-w-[300px] border-[1px] shadow shadow-main2 rounded-lg border-main2">
                    <div class="w-3/5 h-full font-sans p-4 space-y-3">
                        <div class="text-md font-bold w-full">
                            Corrupt high&nbsp;ranking officials
                        </div>
                        <div class="text-gray-500 text-sm">
                            easily launder money mates
                        </div>
                    </div>
                    <div class="w-2/5 h-full bg-main2 flex items-center justify-center">
                        <img class="h-full" src="/src/assets/images/bribery-removebg.png" alt="">
                    </div>
                </div>
            </div>
        </div>

        <div class="flex md:flex-row flex-col justify-between md:min-w-[1200px]">
            <div class="w-2/5  max-md:w-full bg-gray-800 rounded-lg px-16 py-3 flex flex-row justify-between">
                <div class="text-2xl text-gray-100 font-bold text-sans">
                    Statistics
                </div>
                <div class="flex flex-row space-x-2">
                    <div class="w-10 h-10 rounded-sm bg-gray-700 flex items-center justify-center">
                        <span class="material-symbols-outlined text-gray-400">
                            person
                        </span>
                    </div>
                    <div class="flex flex-col text-sm">
                        <div class="h-1/2 font-semibold text-gray-400 ">
                            Persons
                        </div>
                        <div class="text-white ">
                            500
                        </div>
                    </div>
                </div>
                <div class="flex flex-row space-x-2">
                    <div class="w-10 h-10 rounded-sm bg-gray-700 flex items-center justify-center">
                        <span class="material-symbols-outlined text-gray-400">
                            description
                         </span>
                    </div>
                    <div class="flex flex-col text-sm">
                        <div class="h-1/2 font-semibold text-gray-400">
                            Evidence&nbsp;Files
                        </div>
                        <div class="text-white ">
                            500
                        </div>
                    </div>
                </div>
              
            </div>
            <div class="h-full w-[55%] max-md:w-full border-[0.5px] border-gray-300 rounded-lg p-2 flex md:flex-row md:flex-wrap max-md:inline-block flex-col space-x-3 items-center">
                <div class="text-2xl max-md:text-xl font-bold text-sans">
                    Users&nbsp;include
                </div>

                <div class=" flex max-xl:flex-grow flex-row justify-between space-x-1 items-center lg:w-3/5">
                    <div class="text-sm max-md:text-[13px] bg-gray-100 font-medium  text-gray-500 rounded-md px-2 py-1 flex items-center justify-center">
                    Judges
                </div>
                <div class="text-sm max-md:text-[13px] bg-gray-100 font-medium  text-gray-500 rounded-md px-2 py-1 flex items-center justify-center">
                    Court&nbsp;Officials
                </div>
                <div class="text-sm max-md:text-[13px] bg-gray-100 font-medium  text-gray-500 rounded-md px-2 py-1 flex items-center justify-center">
                    Law&nbsp;Enforcement
                </div>
                <div class="text-sm max-md:text-[13px] bg-gray-100 font-medium  text-gray-500 rounded-md px-2 py-1 flex items-center justify-center">
                    Forensics
                </div>
                <div class="text-sm max-md:text-[13px] bg-gray-100 font-medium  text-gray-500 rounded-md px-2 py-1 flex items-center justify-center">
                    Lawyers
                </div>
                <div class="text-sm max-md:text-[13px] bg-gray-100 font-medium  text-gray-500 rounded-md px-2 py-1 flex items-center justify-center">
                    Prosecutors
                </div>
                </div>
                
             
            </div>
        </div>
        <footer class="w-full ">

        </footer>
    </div>
</template>