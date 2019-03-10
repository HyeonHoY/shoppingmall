package com.project.sm.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadService {
	
	// 지정된 폴더가 있는지 확인하는 매서드
	public void checkFolder(String folderName);
	
	// 파일 존재 확인 매서드
	public boolean fileIsLive(String PathFile);
	
	// 파일 쓰기 매서드
	public boolean writeFile(String pathName, MultipartFile mf);
	
	// 파일 삭제
	public void deleteFile(String pathName);
	
	// 폴더 삭제
	public void deleteFolderAll(String path);
	
	// 파일 이동
	public boolean moveFile(String beforeFolder, String afterFolder, String beforeName, String afterName);
	
	// 썸네일 파일 생성
	public void boardThumbnail(int width, int height, String path, String fileName);
}
