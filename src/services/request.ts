import axios from 'axios'

axios.defaults.headers.common['x-business-id'] = '13'
axios.defaults.headers.common['x-channel-id'] = '32'

export interface TemplateModel {
  materialId: number
  backgroundColor: string
  title: string
  imageUrl: string
  imageWidth: number
  imageHeight: number
  price: number
  type: string
}

export const searchTemplateList = async (searchInput: string, pageNum: number = 1) => {
  const res = await axios.post('/api/v3/cp/search-contents/general', {
    q: searchInput,
    page_num: pageNum,
    page_size: 50
  })
  const list: TemplateModel[] = res.data.map((data: any) => {
    return {
      materialId: data?.id,
      backgroundColor: data?.preview?.hex,
      title: data?.title,
      imageUrl: data?.preview?.url,
      imageWidth: data?.preview?.width,
      imageHeight: data?.preview?.height,
      price: data?.price,
      type: data?.type
    } as TemplateModel
  })

  return list
}
