import { create } from 'ipfs-http-client';

// Connect to the IPFS API
const ipfs = create('/ip4/127.0.0.1/tcp/5001');



// Function to add metadata to IPFS
export const addFile =async (file) => {
    try {
        // Add metadata to IPFS 
        const { cid } = await ipfs.add(file);
        return cid.toString();
    } catch (error) {
        console.error('Error adding File to IPFS:', error);
        throw error;
    }
}

export const getFile = async (cid) =>{
    // Function to cat metadata to IPFS
    try {
        // Retrieve metadata from IPFS using CID
        const metadata = await ipfs.cat(cid);

        // Convert metadata from Buffer to string
        const metadataString = metadata.toString('utf-8');

        return metadata;
    } catch (error) {
        console.error('Error getting File from IPFS:', error);
        throw error;
    }

}

//or get the file via http://localhost:8080/{cid}