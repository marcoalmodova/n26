import { LightningElement, track, api } from 'lwc';
import getProductInfo from '@salesforce/apex/ProductInfoController.getProductInfo';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import productNameLabel from '@salesforce/label/c.ProductName';
import productCostLabel from '@salesforce/label/c.ProductCost';

export default class ProductsInfo extends LightningElement {
    @api recordId;
    @track ready=false;
    @track addProducts = [];
    @track mainProduct='';
    @track error;

    label = {
        productNameLabel,
        productCostLabel
    };
    
    connectedCallback(){
        this.getProducts();
    }

    getProducts(){
        getProductInfo({caseId : this.recordId})
            .then(result =>{
                if(typeof result !== 'undefined' && result.length > 0)
                {
                    this.ready = true;
                    this.mainProduct = result[0].Pricebook2.Product__r.Name + ' - ' + result[0].Pricebook2.Country__c;
                    this.addProducts = result;

                    let productsAux = result;
                    for (let i = 0; i < productsAux.length; i++) {
                        //removes parent product to create child product list
                        if(productsAux[i].Product2Id === productsAux[i].Pricebook2.Product__c)
                        {
                            productsAux.splice(i,1);
                            break;
                        }
                    }

                    //check if it's percent
                    productsAux.forEach(function(p){
                        p.isPercent = p.Product2.Pricing_Method__c === 'Percent' ? true : false;
                        p.Percent__c = p.Percent__c/100;
                    });
                    
                    this.addProducts = productsAux;
                }
            })
            .catch(error =>{
                //TO-DO: give a friendly message here
                this.showError('Unexpected error.');
                this.error=error;
            })
    }

    showError(error)
    {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: error,
            variant: 'error',
        });
        this.dispatchEvent(evt);
    }
}