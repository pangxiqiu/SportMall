package com.sportmall.biz;

import com.sportmall.dao.IProductMapper;
import com.sportmall.entity.TProduct;
import com.sportmall.entity.dto.TProductCondition;
import com.sportmall.util.PicUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Service("productBiz")
public class ProductBiz{

    @Autowired
    private IProductMapper productDao;


    public List<TProduct> getAllProducts(TProductCondition tProductCondition) throws Exception {
        return productDao.getAllProducts(tProductCondition);
    }

    public int productCount(TProductCondition tProductCondition)throws  Exception{
        return productDao.productCount(tProductCondition);
    }


    public void addProduct(TProduct product, MultipartFile file1,MultipartFile file2,MultipartFile file3) throws Exception {

        String str1 = PicUpload.getPic(file1);
        if(str1 != null && str1.length()>0){
           product.setImage(str1);
        }
        String str2 = PicUpload.getPic(file2);
        if(str2 != null && str2.length()>0){
            product.setImage1(str2);
        }
        String str3 = PicUpload.getPic(file3);
        if(str3 != null && str3.length()>0){
            product.setImage2(str3);
        }
        productDao.addProduct(product);
    }

    public int updateProduct(TProduct product, MultipartFile file1,MultipartFile file2,MultipartFile file3)throws Exception{
        String str1 = PicUpload.getPic(file1);
        if(str1 != null && str1.length()>0){
            product.setImage(str1);
        }
        String str2 = PicUpload.getPic(file2);
        if(str2 != null && str2.length()>0){
            product.setImage1(str2);
        }
        String str3 = PicUpload.getPic(file3);
        if(str3 != null && str3.length()>0){
            product.setImage2(str3);
        }

        return productDao.updateProduct(product);
    }


    public byte[] getPic(Integer pno) throws Exception {
        byte[] pic;
        TProduct tProduct = productDao.getPic(pno);
        pic = tProduct.getPic();
        return pic;
    }


    public TProduct getProductInfo(Integer pno) throws Exception {
        return productDao.getProductInfo(pno);
    }


    public List<TProduct> getCarProducts(String uname) throws Exception {
        return productDao.getCarProducts(uname);
    }

    public int reduceCount(TProduct product)throws Exception{
        return productDao.reduceCount(product);
    }

    public  Integer deleteProduct (Integer pno,Integer pstate){
        return productDao.deleteProduct(pno,pstate);
    }

    public  Integer addProductCount(Integer pno,Integer count){
        return productDao.addProductCount(pno,count);
    }



}
