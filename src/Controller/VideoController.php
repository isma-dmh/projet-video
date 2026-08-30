<?php

namespace App\Controller;

use App\Entity\Video;
use App\Form\SearchType;
use App\Form\VideoType;
use App\Model\SearchData;
use App\Repository\VideoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Contracts\Translation\TranslatorInterface;

#[Route('/')]
final class VideoController extends AbstractController
{
    #[Route(name: 'app_home', methods: ['GET'])]
    public function index(VideoRepository $videoRepository, Request $request): Response
    {

        $searchData = new SearchData;
        $form = $this->createForm(SearchType::class, $searchData);
        $premium = $this->getUser() && $this->getUser()->isVerified();
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $searchData->page = $request->query->getInt("page", 1);
            $videos = $videoRepository->findBySearch($searchData, $premium);
            return $this->render('video/index.html.twig', [
                "formSearch" => $form,
                "videos" => $videos,
                "query" => $searchData->q
            ]);
        }

        return $this->render('video/index.html.twig', [
            "formSearch" => $form->createView(),
            "videos" => $videoRepository->findVideos($request->query->getInt("page", 1), $premium),
            "query" => $searchData->q
        ]);
    }

    #[Route('/video/create', name: 'app_video_create', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager, TranslatorInterface $translator): Response
    {
        if (!$this->getUser()) {

            $this->addFlash("error", $translator->trans("videoController.create.NotConnected"));
            return $this->redirectToRoute("app_home");
        }

        if (!$this->getUser()->isVerified()) {
            $this->addFlash("error", $translator->trans("videoController.create.NotVerified"));
            return $this->redirectToRoute("app_home");
        }

        $video = new Video();
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $video->setUser($this->getUser());
            $entityManager->persist($video);
            $entityManager->flush();

            $this->addFlash("success", $translator->trans("videoController.create.successfully"));
            return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('video/create.html.twig', [
            'video' => $video,
            'form' => $form,
        ]);
    }

    #[Route('/video/{id}', name: 'app_video_show', methods: ['GET'])]
    public function show(Video $video, TranslatorInterface $translator): Response
    {

        if ($video->isPremiumVideo() && (!$this->getUser() || !$this->getUser()->isVerified())) {
            $this->addFlash("error", $translator->trans("videoController.show.NotVerified"));
            return $this->redirectToRoute("app_home");
        }
        return $this->render('video/show.html.twig', [
            'video' => $video,
        ]);
    }

    #[Route('/video/{id}/edit', name: 'app_video_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Video $video, EntityManagerInterface $entityManager, TranslatorInterface $translator): Response
    {

        if (!$this->getUser()) {
            $this->addFlash("error", $translator->trans("videoController.edit.NotConnected"));
            return $this->redirectToRoute("app_home");
        }

        if ($this->getUser() !== $video->getUser()) {
            $this->addFlash("error", $translator->trans("videoController.edit.NotUser"));
            return $this->redirectToRoute("app_home");
        }

        $form = $this->createForm(VideoType::class, $video, ["button_label" => "videoForm.label.update"]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();
            $this->addFlash("success", $translator->trans("videoController.edit.successfully"));
            return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('video/edit.html.twig', [
            'video' => $video,
            'form' => $form,
        ]);
    }

    #[Route('/video/{id}/delete', name: 'app_video_delete', methods: ['POST'])]
    public function delete(Request $request, Video $video, EntityManagerInterface $entityManager, TranslatorInterface $translator): Response
    {
        $title = $video->getTitle();
        if (!$this->isCsrfTokenValid('delete' . $video->getId(), $request->getPayload()->getString('_token'))) {
            $this->addFlash("error", $translator->trans("videoController.delete.delete_error"));
            return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
        }

        $entityManager->remove($video);
        $entityManager->flush();
        $this->addFlash("info", $translator->trans("videoController.delete", ["title" => $title]));
        return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
    }
}
