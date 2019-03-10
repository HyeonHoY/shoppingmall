package com.project.sm.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Service
@Slf4j
public class FileUploadServiceImpl implements FileUploadService {

	// 폴더 유무 확인 매서드
	@Override
	public void checkFolder(String folderName) {
		
		log.info("checkFolder");
		
		File folderCheck = new File(folderName);
		
		if(!folderCheck.exists()) {
			folderCheck.mkdirs();
		}
	}
	
	// 파일 존재 확인 매서드
	@Override
	public boolean fileIsLive(String PathFile) {
		
		log.info("fileIsLive");
		log.info("checkFile = "+PathFile);
		
		boolean result = false;
		File file = new File(PathFile);
		
		if(!file.exists()) {
			result = true;
			log.info("###########################");
			log.info(""+result);
		} else {
			result = false;
			log.info("###########################");
			log.info(""+result);
		}
		
		return result;
	} //
	
	// 파일 쓰기 매서드
	@Override
	public boolean writeFile(String pathName, MultipartFile mf) {

		log.info("writeFile");
		log.info("########## mf = "+mf.getOriginalFilename());
		
		FileOutputStream fos = null;
		File printFile = new File(pathName);
		boolean result = false;
		
		try {
			log.info("2");
			byte[] bytes = mf.getBytes();
			fos = new FileOutputStream(printFile);
			fos.write(bytes);
			result = true;
			
		} catch (IOException e) {
			log.info("3");
			e.printStackTrace();
			result = false;
		} finally {
			
			try {
				log.info("::::::::::");
				fos.close();
			} catch (IOException e) {
				log.error("파일 출력 에러!!");
				e.printStackTrace();
			} // try
			
		} // finally
		return result;
	}
	
	// 파일 삭제
	@Override
	public void deleteFile(String pathName) {
		
		// log.info("deleteFile");
		
		File deleteFile = new File(pathName);
		
		// 파일이 존재할 경우
		if(deleteFile.exists()) {
			// 파일 삭제
			deleteFile.delete();
		}
	}

	// 폴더 삭제
	@Override
	public void deleteFolderAll(String path) {
		
		File deleteFolder = new File(path);
		
		// 폴더가 존재할 경우
		if(deleteFolder.exists()) {
			
			File[] deleteFolderList = deleteFolder.listFiles();
			
			// 폴더 개수만큼 반복
			for(int i=0; i<deleteFolderList.length; i++) {
				
				// 해당 list가 파일일 경우
				if(deleteFolderList[i].isFile()) {
					
					// 파일 삭제
					deleteFolderList[i].delete();
				} else {
					
					deleteFolderAll(deleteFolderList[i].getPath());
				}
				
			 }// for
			deleteFolder.delete();
 		 } // if
	}
	
	@Override
	public boolean moveFile(String beforeFolder, String afterFolder, String beforeName, String afterName) {

		boolean result = false;
		File folder = new File(afterFolder);
		
		// 폴더가 없을 경우
		if(!folder.exists()) {
			
			// 폴더를 만든다.
			folder.mkdirs();
		}
		try {
			File file = new File(beforeFolder+beforeName);
			
			if(file.renameTo(new File(afterFolder+afterName))) {
				result = true;
			} else {
				result = false;
			}
		} catch(Exception e) {
			log.error("파일 이동 오류");
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public void boardThumbnail(int width, int height, String path, String fileName) {
	
		log.info("path = "+path);
		log.info("fileName = "+fileName);
		
		
		
		// 썸네일 폴더
		String thumbPath = path+"thumbnail/"; 
		// 썸네일 파일
		// String thumbnailName = fileName.split("\\.")[0]+".png";
		
		// 썸네일 저장 경로
		File checkthumbnailRoute = new File(thumbPath);
		
		// 폴더 유무 확인
		if(!checkthumbnailRoute.exists()) {
			
			//폴더가 없을 경우 생성
			checkthumbnailRoute.mkdirs();
		}
		
		try {
			File outFileName = new File(path+fileName);
			File thumbnail = new File(fileName);
			Thumbnails.of(outFileName).forceSize(width, height).toFile(thumbPath+thumbnail);
			
		} catch (IOException e) {
			log.error("썸네일 파일 저장 실패!!");
			e.printStackTrace();
		}
	}

}
