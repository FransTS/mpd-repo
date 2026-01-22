// Update existing Google Docs with new content (v4.9.1 with Persona 016)
import fs from 'fs';
import path from 'path';
import { google } from 'googleapis';

// Paths
const CREDS_PATH = 'C:/GitHub/google-docs-mcp/credentials.json';
const TOKEN_PATH = 'C:/GitHub/google-docs-mcp/token.json';
const MPD_EXPORT = 'G:/My Drive/Shared_Download/AI_Folder/MPD/GDocs_Export';

// Existing doc IDs from previous creation
const DOC_IDS = {
    'Frans_MPD_v4.9_Complete': '1bs0XkXCA4i4-MJE5TYtIcnnVKuFfQJ0QQ8bEy5JYVyg',
    '01_MPD_Master_Index': '17b-RDo3vzETU29FmOyi-GUcYv9sSV2stpgPGyDy-Af0',
    '02_Persona_Registry': '1XBCXv7zGrlMsoCPUoF-ZodyI7foVv-YKJYagLDkVRe4',
    '07_Personas_011-015': '1Nue-ea9hBtx3FxoRFidUCUQ9sGshgCoHrNYiWIc6p84'
};

console.log('Starting Google Docs update...');

async function authorize() {
    console.log('Reading credentials...');
    const credentials = JSON.parse(fs.readFileSync(CREDS_PATH, 'utf8'));
    const token = JSON.parse(fs.readFileSync(TOKEN_PATH, 'utf8'));
    
    const creds = credentials.installed || credentials.web;
    const { client_id, client_secret } = creds;
    
    const oAuth2Client = new google.auth.OAuth2(client_id, client_secret);
    oAuth2Client.setCredentials(token);
    
    console.log('Authorization complete');
    return oAuth2Client;
}

async function replaceDocContent(docs, docId, title, newContent) {
    console.log(`Updating: ${title}`);
    
    // First, get the current document to find its length
    const doc = await docs.documents.get({ documentId: docId });
    const endIndex = doc.data.body.content[doc.data.body.content.length - 1].endIndex - 1;
    
    // Delete all existing content (except the last newline)
    if (endIndex > 1) {
        await docs.documents.batchUpdate({
            documentId: docId,
            requestBody: {
                requests: [{
                    deleteContentRange: {
                        range: {
                            startIndex: 1,
                            endIndex: endIndex
                        }
                    }
                }]
            }
        });
    }
    
    // Insert new content
    await docs.documents.batchUpdate({
        documentId: docId,
        requestBody: {
            requests: [{
                insertText: {
                    location: { index: 1 },
                    text: newContent
                }
            }]
        }
    });
    
    console.log(`  ✓ Updated: https://docs.google.com/document/d/${docId}`);
}

async function main() {
    const auth = await authorize();
    const docs = google.docs({ version: 'v1', auth });
    
    // Update each document
    const filesToUpdate = [
        'Frans_MPD_v4.9_Complete.md',
        '01_MPD_Master_Index.md',
        '02_Persona_Registry.md',
        '07_Personas_011-015.md'
    ];
    
    console.log(`\nUpdating ${filesToUpdate.length} Google Docs with Persona 016...`);
    
    for (const file of filesToUpdate) {
        const filePath = path.join(MPD_EXPORT, file);
        const title = file.replace('.md', '');
        
        if (DOC_IDS[title] && fs.existsSync(filePath)) {
            const content = fs.readFileSync(filePath, 'utf8');
            await replaceDocContent(docs, DOC_IDS[title], title, content);
        } else {
            console.log(`  ⚠ Skipped: ${file} (no doc ID or file not found)`);
        }
    }
    
    console.log('\n=== UPDATE COMPLETE ===');
    console.log('All MPD Google Docs updated with Persona 016: Airbnb Host Assistant');
}

main().catch(err => {
    console.error('Error:', err.message);
    process.exit(1);
});
