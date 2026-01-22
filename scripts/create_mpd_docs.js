// Create Google Docs from MD files
// Uses the existing credentials from google-docs-mcp
// Output to log file

const fs = require('fs');
const path = require('path');
const { google } = require('googleapis');

// Log file
const LOG_FILE = 'G:\\My Drive\\Shared_Download\\AI_Folder\\MPD\\scripts\\gdocs_creation.log';
function log(msg) {
    const line = `[${new Date().toISOString()}] ${msg}\n`;
    fs.appendFileSync(LOG_FILE, line);
    console.log(msg);
}

// Clear log
fs.writeFileSync(LOG_FILE, '=== Google Docs Creation Log ===\n');
log('Starting...');

// Paths
const CREDS_PATH = 'C:\\GitHub\\google-docs-mcp\\credentials.json';
const TOKEN_PATH = 'C:\\GitHub\\google-docs-mcp\\token.json';
const MPD_EXPORT = 'G:\\My Drive\\Shared_Download\\AI_Folder\\MPD\\GDocs_Export';
const TARGET_FOLDER_NAME = 'MPD_GDocs_v4.9';

async function authorize() {
    log('Reading credentials...');
    const credentials = JSON.parse(fs.readFileSync(CREDS_PATH, 'utf8'));
    const token = JSON.parse(fs.readFileSync(TOKEN_PATH, 'utf8'));
    
    const creds = credentials.installed || credentials.web;
    if (!creds) {
        throw new Error('No credentials found in credentials.json');
    }
    
    const { client_id, client_secret } = creds;
    log(`Client ID: ${client_id.substring(0, 20)}...`);
    
    const oAuth2Client = new google.auth.OAuth2(client_id, client_secret);
    oAuth2Client.setCredentials(token);
    
    log('Authorization complete');
    return oAuth2Client;
}

async function findOrCreateFolder(drive, folderName, parentId = null) {
    let query = `name='${folderName}' and mimeType='application/vnd.google-apps.folder' and trashed=false`;
    if (parentId) query += ` and '${parentId}' in parents`;
    
    log(`Searching for folder: ${folderName}`);
    const res = await drive.files.list({ q: query, fields: 'files(id, name)' });
    
    if (res.data.files && res.data.files.length > 0) {
        log(`Found existing folder: ${folderName} (${res.data.files[0].id})`);
        return res.data.files[0].id;
    }
    
    log(`Creating folder: ${folderName}`);
    const fileMetadata = {
        name: folderName,
        mimeType: 'application/vnd.google-apps.folder'
    };
    if (parentId) fileMetadata.parents = [parentId];
    
    const folder = await drive.files.create({ resource: fileMetadata, fields: 'id' });
    log(`Created folder: ${folderName} (${folder.data.id})`);
    return folder.data.id;
}

async function createGoogleDoc(docs, drive, title, content, folderId) {
    log(`Creating doc: ${title}`);
    
    // Create empty doc
    const docRes = await docs.documents.create({ requestBody: { title } });
    const docId = docRes.data.documentId;
    log(`Created doc ID: ${docId}`);
    
    // Move to folder
    await drive.files.update({
        fileId: docId,
        addParents: folderId,
        fields: 'id, parents'
    });
    log(`Moved to folder`);
    
    // Insert content
    if (content && content.trim()) {
        await docs.documents.batchUpdate({
            documentId: docId,
            requestBody: {
                requests: [{
                    insertText: {
                        location: { index: 1 },
                        text: content
                    }
                }]
            }
        });
        log(`Inserted content (${content.length} chars)`);
    }
    
    return docId;
}

async function main() {
    try {
        log('=== Starting Google Docs creation ===');
        
        const auth = await authorize();
        const docs = google.docs({ version: 'v1', auth });
        const drive = google.drive({ version: 'v3', auth });
        
        // Find AI_Folder
        log('Searching for AI_Folder...');
        const aiFolder = await drive.files.list({
            q: "name='AI_Folder' and mimeType='application/vnd.google-apps.folder' and trashed=false",
            fields: 'files(id, name)'
        });
        
        let parentId = null;
        if (aiFolder.data.files && aiFolder.data.files.length > 0) {
            parentId = aiFolder.data.files[0].id;
            log(`Found AI_Folder: ${parentId}`);
        } else {
            log('AI_Folder not found, creating in root');
        }
        
        // Create MPD folder
        const mpdFolderId = await findOrCreateFolder(drive, TARGET_FOLDER_NAME, parentId);
        
        // Files to convert
        const files = [
            'Frans_MPD_v4.9_Complete.md',
            '01_MPD_Master_Index.md',
            '02_Persona_Registry.md',
            '03_Skill_Registry.md',
            '04_Protocols.md',
            '05_Personas_001-005.md',
            '06_Personas_006-010.md',
            '07_Personas_011-015.md'
        ];
        
        log(`\nCreating ${files.length} Google Docs...`);
        
        for (const file of files) {
            const filePath = path.join(MPD_EXPORT, file);
            if (fs.existsSync(filePath)) {
                const content = fs.readFileSync(filePath, 'utf8');
                const title = file.replace('.md', '');
                await createGoogleDoc(docs, drive, title, content, mpdFolderId);
                log(`✓ ${title}`);
            } else {
                log(`✗ File not found: ${file}`);
            }
        }
        
        log('\n=== COMPLETE ===');
        log(`Check Google Drive for folder: ${TARGET_FOLDER_NAME}`);
        
    } catch (err) {
        log(`ERROR: ${err.message}`);
        log(err.stack);
        process.exit(1);
    }
}

main();
