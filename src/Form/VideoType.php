<?php

namespace App\Form;

use App\Entity\Video;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class VideoType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', TextType::class, [
                "label" => "videoForm.label.title",
                "attr" => [
                    "placeholder" => "videoForm.placeholder.title"
                ]
            ])
            ->add('videoLink', TextType::class, [
                "label" => "videoForm.label.videoLink",
                'attr' => [
                    'placeholder' => 'https://www.youtube.com/embed/...',
                ]
            ])
            ->add('description', TextareaType::class, [
                "label" => "videoForm.label.description",
                'attr' => [
                    'placeholder' => 'videoForm.placeholder.description',
                ],
            ])
            ->add('premiumVideo', CheckboxType::class, [
                "label" => "videoForm.label.premium",
                "required" => false

            ])
            ->add('submit', SubmitType::class, [
                'label' => $options["button_label"],
                'attr' => [
                    'class' => 'btn-submit',
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Video::class,
            "button_label" => "videoForm.label.submit"
        ]);
    }
}
